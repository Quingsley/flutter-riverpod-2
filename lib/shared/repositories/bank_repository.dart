import 'dart:async';

import 'package:bank_app/features/deposit/presentation/providers/deposit_provider.dart';
import 'package:bank_app/features/expenses/data/models/expense_model.dart';
import 'package:bank_app/features/landing/data/models/account_model.dart';
import 'package:bank_app/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:bank_app/helpers/utils.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepositService extends ChangeNotifier {
  Account? _selectedAccount;
  List<Expense> expenses = [];
  final Ref ref;

  DepositService(this.ref);

  set setAccount(Account? acct) {
    _selectedAccount = acct;
    notifyListeners();
  }

  void resetAccountSelection() {
    setAccount = null;
    notifyListeners();
  }

  Account? get accountSelected => _selectedAccount;

  Future<bool> performDeposit() {
    Completer<bool> depositCompleter = Completer();
    var userId = ref.watch(firebaseAuthInstance).currentUser!.uid;
    var amountToDeposit = ref.read(depositRepositoryProvider).toInt();
    var db = ref.watch(firebaseDbProvider);

    DocumentReference doc = db
        .collection(Collection.accounts.name)
        .doc(userId)
        .collection(Collection.user_accounts.name)
        .doc(_selectedAccount!.id);

    doc.update({'balance': _selectedAccount!.balance! + amountToDeposit}).then(
        (value) {
      depositCompleter.complete(true);
    }).onError((error, stackTrace) {
      depositCompleter.completeError(error.toString());
    });
    return depositCompleter.future;
  }

  Future<bool> performWithdrawal() {
    Completer<bool> withdrawCompleter = Completer();
    var userId = ref.watch(firebaseAuthInstance).currentUser!.uid;
    var amountToWithDraw = ref.read(withdrawRepositoryProvider).toInt();
    var db = ref.watch(firebaseDbProvider);

    DocumentReference doc = db
        .collection(Collection.accounts.name)
        .doc(userId)
        .collection(Collection.user_accounts.name)
        .doc(_selectedAccount!.id);
    doc.update({'balance': _selectedAccount!.balance! - amountToWithDraw}).then(
        (value) {
      withdrawCompleter.complete(true);
    }).onError((error, stackTrace) {
      withdrawCompleter.completeError(error.toString());
    });

    return withdrawCompleter.future;
  }

  Stream<List<Expense>> getExpenses() {
    var userId = ref.watch(firebaseAuthInstance).currentUser!.uid;
    var controller = StreamController<List<Expense>>();
    var db = ref.watch(firebaseDbProvider);
    db
        .collection(Collection.accounts.name)
        .doc(userId)
        .collection(Collection.user_expenses.name)
        .snapshots() //stream of user_expense collection
        .listen((QuerySnapshot collection) {
      expenses.clear();
      for (var doc in collection.docs) {
        var expenseJson = doc.data() as Map<String, dynamic>;
        expenses.add(Expense.fromJson(
          expenseJson,
          doc.id,
        ));
      }
      controller.add(expenses);
    }); //Listen on the stream

    return controller.stream;
  }

  void addExpense(Expense expense) {
    var userId = ref.watch(firebaseAuthInstance).currentUser!.uid;
    var db = ref.watch(firebaseDbProvider);
    CollectionReference expenseCollection = db
        .collection(Collection.accounts.name)
        .doc(userId)
        .collection(Collection.user_expenses.name);

    expenseCollection.add({
      'amount': expense.amount,
      'timeStamp': expense.timeStamp,
      'name': expense.name
    }).then((value) {
      print({'document added': value});
    }).catchError((error) => print(error.toString()));
  }

  void deleteExpense(String expenseId) {
    var userId = ref.watch(firebaseAuthInstance).currentUser!.uid;
    var db = ref.watch(firebaseDbProvider);

    DocumentReference expenseToDelete = db
        .collection(Collection.accounts.name)
        .doc(userId)
        .collection(Collection.user_expenses.name)
        .doc(expenseId);

    expenseToDelete
        .delete()
        .then((value) => print('Document deleted'))
        .catchError((error) => print(error.toString()));
  }
}

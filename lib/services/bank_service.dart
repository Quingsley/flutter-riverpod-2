import 'dart:async';

import 'package:bank_app/features/deposit/presentation/providers/deposit_provider.dart';
import 'package:bank_app/features/expenses/data/models/expense_model.dart';
import 'package:bank_app/features/accounts/data/models/account_model.dart';
import 'package:bank_app/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:bank_app/helpers/utils.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BankService extends ChangeNotifier {
  Account? _selectedAccount;
  List<Expense> expenses = [];
  final Ref ref;
  late final FirebaseFirestore _db;
  late final String? _userId;

  BankService(this.ref) {
    _userId = ref.watch(firebaseAuthInstance).currentUser!.uid;
    _db = ref.watch(firebaseDbProvider);
  }

  set setAccount(Account? acct) {
    _selectedAccount = acct;
    notifyListeners();
  }

  void resetAccountSelection() {
    setAccount = null;
    notifyListeners();
  }

  Account? get accountSelected => _selectedAccount;

  Future<bool> createAccount(Account data) {
    Completer<bool> newAccountCompleter = Completer();
    CollectionReference userAccounts = _db
        .collection(Collection.accounts.name)
        .doc(_userId)
        .collection(Collection.user_accounts.name);
    userAccounts.add({
      'account_number': data.accountNumber,
      'balance': 0.0,
      'type': data.type
    }).then((value) {
      newAccountCompleter.complete(true);
    }).catchError((error, stackTrace) {
      newAccountCompleter.completeError(error.toString());
    });

    return newAccountCompleter.future;
  }

  Future<bool> performDeposit() {
    Completer<bool> depositCompleter = Completer();
    var amountToDeposit = ref.read(depositRepositoryProvider).toInt();

    DocumentReference doc = _db
        .collection(Collection.accounts.name)
        .doc(_userId)
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
    var amountToWithDraw = ref.read(withdrawRepositoryProvider).toInt();

    DocumentReference doc = _db
        .collection(Collection.accounts.name)
        .doc(_userId)
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
    var controller = StreamController<List<Expense>>();
    _db
        .collection(Collection.accounts.name)
        .doc(_userId)
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
    }).onError((error, stackTrace) {
      throw error;
    }); //Listen on the stream

    return controller.stream;
  }

  Future<bool> addExpense(Expense expense) {
    Completer<bool> addExpenseComplete = Completer();
    CollectionReference expenseCollection = _db
        .collection(Collection.accounts.name)
        .doc(_userId)
        .collection(Collection.user_expenses.name);

    expenseCollection.add({
      'amount': expense.amount,
      'timeStamp': expense.timeStamp,
      'name': expense.name
    }).then((value) {
      // print({'document added': value});
      addExpenseComplete.complete(true);
    }).catchError((error) {
      // print(error.toString());
      addExpenseComplete.completeError(error.toString());
    });
    return addExpenseComplete.future;
  }

  Future<bool> deleteExpense(String expenseId) {
    Completer<bool> deleteExpenseCompleter = Completer();
    DocumentReference expenseToDelete = _db
        .collection(Collection.accounts.name)
        .doc(_userId)
        .collection(Collection.user_expenses.name)
        .doc(expenseId);

    expenseToDelete.delete().then((value) {
      /*print('Document deleted')*/
      deleteExpenseCompleter.complete(true);
    }).catchError((error) {
      // print(error.toString());
      deleteExpenseCompleter.completeError(error.toString());
    });
    return deleteExpenseCompleter.future;
  }
}

import 'dart:async';

import 'package:bank_app/features/deposit/presentation/providers/deposit_provider.dart';
import 'package:bank_app/features/landing/data/models/account_model.dart';
import 'package:bank_app/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:bank_app/helpers/utils.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepositService extends ChangeNotifier {
  Account? _selectedAccount;
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
        .collection(Collcetion.accounts.name)
        .doc(userId)
        .collection(Collcetion.user_accounts.name)
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
        .collection(Collcetion.accounts.name)
        .doc(userId)
        .collection(Collcetion.user_accounts.name)
        .doc(_selectedAccount!.id);
    doc.update({'balance': _selectedAccount!.balance! - amountToWithDraw}).then(
        (value) {
      withdrawCompleter.complete(true);
    }).onError((error, stackTrace) {
      withdrawCompleter.completeError(error.toString());
    });

    return withdrawCompleter.future;
  }
}

import 'dart:async';

import 'package:bank_app/features/accounts/data/models/account_model.dart';
import 'package:bank_app/helpers/utils.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataBaseProvider {
  final Ref ref;
  late final String? _userId;
  late final FirebaseFirestore _db;
  DataBaseProvider(this.ref) {
    _userId = ref.read(firebaseAuthInstance).currentUser?.uid;
    _db = ref.read(firebaseDbProvider);
  }

  Future<List<Account>> getDataFromDB() {
    Completer<List<Account>> dataCompleter = Completer();
    List<Account> accounts = [];
    _db
        .collection(Collection.accounts.name)
        .doc(_userId)
        .collection(Collection.user_accounts.name)
        .get()
        .then((QuerySnapshot collection) {
      for (var doc in collection.docs) {
        var accDoc = doc.data() as Map<String, dynamic>;
        var acct = Account.fromJSON(accDoc, doc.id);
        accounts.add(acct);
      }
      dataCompleter.complete(accounts);
    }).catchError((onError) {
      dataCompleter.completeError(onError);
    }).onError((error, stackTrace) {
      dataCompleter.completeError(error!);
    });
    return dataCompleter.future;
  }
}

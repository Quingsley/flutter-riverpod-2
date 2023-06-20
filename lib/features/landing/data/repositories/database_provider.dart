import 'dart:async';

import 'package:bank_app/features/landing/data/models/account_model.dart';
import 'package:bank_app/helpers/utils.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataBaseProvider {
  final Ref ref;
  DataBaseProvider(this.ref);

  Future<List<Account>> getDataFromDB() {
    Completer<List<Account>> dataCompleter = Completer();
    var db = ref.read(firebaseDbProvider);
    var userId = ref.read(firebaseAuthInstance).currentUser?.uid;
    List<Account> accounts = [];
    db
        .collection(Collection.accounts.name)
        .doc(userId)
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

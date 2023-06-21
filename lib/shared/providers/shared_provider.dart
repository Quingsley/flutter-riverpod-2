import 'package:bank_app/shared/repositories/auth_repository.dart';
import 'package:bank_app/shared/repositories/bank_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthInstance =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authRepositoryProvider =
    ChangeNotifierProvider<AuthRepository>((ref) => AuthRepository(ref));

final firebaseDbProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final bankServiceProvider =
    ChangeNotifierProvider<BankService>((ref) => BankService(ref));

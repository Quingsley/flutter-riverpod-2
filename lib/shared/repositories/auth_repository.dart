import 'dart:async';

import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository extends ChangeNotifier {
  final Ref ref;
  late FirebaseAuth _firebaseAuth;
  String _errorMessage = '';

  void errMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  AuthRepository(this.ref) {
    _firebaseAuth = ref.read(firebaseAuthInstance);
  }
  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    Completer<bool> signUpCompleter = Completer();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      signUpCompleter.complete(true);
    } on FirebaseAuthException catch (e) {
      errMessage(e.message!);
      signUpCompleter.completeError(e.toString());
    } catch (e) {
      signUpCompleter.completeError(e.toString());
    }
    return signUpCompleter.future;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    Completer<bool> signinCompleter = Completer();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      signinCompleter.complete(true);
    } on FirebaseAuthException catch (e) {
      errMessage(e.message!);
      signinCompleter.completeError(e.toString());
    } catch (e) {
      errMessage(e.toString());
      signinCompleter.completeError(e.toString());
    }
    return signinCompleter.future;
  }

  Future<bool> forgotPassword(String email) async {
    Completer<bool> forgetPasswordCompleter = Completer();

    await _firebaseAuth
        .sendPasswordResetEmail(
            email: _firebaseAuth.currentUser != null
                ? _firebaseAuth.currentUser!.email!
                : email)
        .then((value) {
      forgetPasswordCompleter.complete(true);
      notifyListeners();
    }).onError((error, stackTrace) {
      forgetPasswordCompleter.complete(false);
      errMessage(error.toString());
      notifyListeners();
    });

    return forgetPasswordCompleter.future;
  }

  Future<bool> confirmPasswordReset(String code, String newPassword) async {
    Completer<bool> confirmPasswordReset = Completer();
    await _firebaseAuth
        .confirmPasswordReset(code: code, newPassword: newPassword)
        .then((value) {
      confirmPasswordReset.complete(true);
    }).onError((error, stackTrace) {
      confirmPasswordReset.complete(false);
      errMessage(error.toString());
    });

    return confirmPasswordReset.future;
  }

  Future<bool> signOut() async {
    Completer<bool> signoutCompleter = Completer();
    try {
      await _firebaseAuth.signOut();
      signoutCompleter.complete(true);
      notifyListeners();
    } catch (e) {
      signoutCompleter.completeError(e);
      errMessage(e.toString());
    }
    return signoutCompleter.future;
  }

  void clearErrorMessage() {
    _errorMessage = '';
    notifyListeners();
  }
}

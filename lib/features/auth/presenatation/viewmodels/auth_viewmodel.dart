import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthViewModel {
  final Ref ref;

  AuthViewModel(this.ref);

  String get errorMessage => ref.watch(authRepositoryProvider).errorMessage;

  Future<bool> signIn(String email, String password) async {
    return await ref
        .read(authRepositoryProvider.notifier)
        .signInWithEmailAndPassword(email, password);
  }

  Future<bool> signUp(String email, String password) async {
    return await ref
        .read(authRepositoryProvider.notifier)
        .signUpWithEmailAndPassword(email, password);
  }

  Future<bool> signOut() async {
    return ref.read(authRepositoryProvider.notifier).signOut();
  }

  Future<bool> forgotPasswordHandler(String email) {
    return ref.read(authRepositoryProvider.notifier).forgotPassword(email);
  }

  void clearErrorMessage() {
    ref.read(authRepositoryProvider.notifier).clearErrorMessage();
  }
}

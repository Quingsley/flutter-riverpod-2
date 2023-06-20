import 'package:bank_app/features/auth/data/repositories/ilogin_repository.dart';
import 'package:bank_app/features/auth/data/repositories/mock_login_repository.dart';
import 'package:bank_app/features/auth/presenatation/viewmodels/auth_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mockLoginProvider =
    Provider<ILoginRepository>((ref) => MockLoginRepsoitory());

final authViewModelProvider = Provider<AuthViewModel>((ref) {
  return AuthViewModel(ref);
});

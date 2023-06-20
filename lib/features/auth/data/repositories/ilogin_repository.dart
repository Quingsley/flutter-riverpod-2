import 'package:bank_app/features/auth/data/models/login.model.dart';

abstract class ILoginRepository {
  Future<bool> loginWithEmailAndPassword(LoginUserModel user);
}

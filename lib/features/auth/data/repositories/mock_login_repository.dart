import 'package:bank_app/features/auth/data/models/login.model.dart';
import 'package:bank_app/features/auth/data/repositories/ilogin_repository.dart';

class MockLoginRepsoitory implements ILoginRepository {
  @override
  Future<bool> loginWithEmailAndPassword(LoginUserModel user) async {
    if (user.userId == '123') {
      return true;
    }
    return false;
  }
}

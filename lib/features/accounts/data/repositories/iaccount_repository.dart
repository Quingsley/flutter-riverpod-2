import 'package:bank_app/features/accounts/data/models/account_model.dart';

abstract class IAccountRepository {
  Future<List<Account>> getAccountData();
}

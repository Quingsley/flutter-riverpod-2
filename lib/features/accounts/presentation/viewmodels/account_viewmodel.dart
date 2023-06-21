import 'package:bank_app/features/accounts/data/models/account_model.dart';
import 'package:bank_app/features/accounts/data/repositories/iaccount_repository.dart';

class AccountViewModel {
  final IAccountRepository accountRepository;
  AccountViewModel(this.accountRepository);

  Future<List<Account>> getUserAccounts() async {
    var data = await accountRepository.getAccountData();
    return data;
  }
}

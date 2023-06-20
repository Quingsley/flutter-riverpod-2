import 'package:bank_app/features/landing/data/models/account_model.dart';
import 'package:bank_app/features/landing/data/repositories/iaccount_repository.dart';

class AccountViewModel {
  final IAccountRepository accountRepository;
  AccountViewModel(this.accountRepository);

  Future<List<Account>> getUserAccounts() async {
    var data = await accountRepository.getAccountData();
    return data;
  }
}

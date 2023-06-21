import 'package:bank_app/features/accounts/data/models/account_model.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewAccountViewModel {
  final Ref ref;

  NewAccountViewModel(this.ref);

  Future<bool> createNewAccount(Account account) {
    return ref.read(bankServiceProvider).createAccount(account);
  }
}

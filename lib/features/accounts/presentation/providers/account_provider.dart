import 'package:bank_app/features/accounts/data/repositories/account.repository.dart';
import 'package:bank_app/features/accounts/data/repositories/database_provider.dart';
import 'package:bank_app/features/accounts/data/repositories/iaccount_repository.dart';
import 'package:bank_app/features/accounts/presentation/viewmodels/account_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountDatabaseProvider =
    Provider<DataBaseProvider>((ref) => DataBaseProvider(ref));

final accountRepositoryProvider =
    Provider<IAccountRepository>((ref) => AccountRepository(ref));

final accountViewModelProvider = Provider<AccountViewModel>((ref) {
  var repo = ref.read(accountRepositoryProvider);
  return AccountViewModel(repo);
});

final userAccountFutureListProvider = FutureProvider.autoDispose((ref) {
  var accounts = ref.read(accountViewModelProvider).getUserAccounts();
  return accounts;
});

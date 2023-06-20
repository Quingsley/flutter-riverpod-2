import 'package:bank_app/features/landing/data/models/account_model.dart';
import 'package:bank_app/features/landing/data/repositories/iaccount_repository.dart';
import 'package:bank_app/features/landing/presentation/providers/account_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountRepository implements IAccountRepository {
  final Ref ref;

  AccountRepository(this.ref);
  @override
  Future<List<Account>> getAccountData() {
    return ref.read(accountDatabaseProvider).getDataFromDB();
  }
}

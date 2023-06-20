import 'package:bank_app/features/deposit/presentation/providers/deposit_provider.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepositVM {
  final Ref ref;

  DepositVM(this.ref);

  Future<bool> performDeposit() {
    var bankDepositFunction =
        ref.read(bankServiceProvider.notifier).performDeposit();
    return bankDepositFunction;
  }

  void resetDepositAmount() {
    ref.read(depositRepositoryProvider.notifier).resetDepositRepository();
  }
}

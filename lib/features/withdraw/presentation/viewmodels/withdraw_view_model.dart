import 'package:bank_app/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WithdrawalViewModel {
  final Ref ref;

  WithdrawalViewModel(this.ref);

  Future<bool> performWithdraw() {
    var withdrawFunction =
        ref.read(bankServiceProvider.notifier).performWithdrawal();
    return withdrawFunction;
  }

  void resetWithDrawAmount() {
    ref.read(withdrawRepositoryProvider.notifier).resetWithDrawRepository();
  }
}

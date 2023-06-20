import 'package:bank_app/features/withdraw/presentation/viewmodels/withdraw_view_model.dart';
import 'package:bank_app/features/withdraw/repositories/withdraw_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final withdrawRepositoryProvider =
    StateNotifierProvider<WithdrawRepository, double>(
        (ref) => WithdrawRepository());

final withDrawVMProvider =
    Provider<WithdrawalViewModel>((ref) => WithdrawalViewModel(ref));

final performWithDrawFutureProvider = FutureProvider.autoDispose<bool>((ref) {
  var withDrawVM = ref.watch(withDrawVMProvider);
  return withDrawVM.performWithdraw();
});

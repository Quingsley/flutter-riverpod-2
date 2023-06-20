import 'package:bank_app/features/deposit/data/repositories/deposit_repository.dart';
import 'package:bank_app/features/deposit/data/repositories/ideposit_repository.dart';
import 'package:bank_app/features/deposit/data/repositories/mock_deposit_repository.dart';
import 'package:bank_app/features/deposit/presentation/viewmodels/deposit_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mockDepositRepositoryProvider =
    Provider<IDepositRepository>((ref) => MockDepositRepository());

final depositRepositoryProvider =
    StateNotifierProvider<DepositRepository, double>(
        (ref) => DepositRepository());

final depositVMProvider = Provider<DepositVM>((ref) => DepositVM(ref));

final depositTransactionFutureProvider =
    FutureProvider.autoDispose<bool>((ref) {
  var perFormDeposit = ref.watch(depositVMProvider).performDeposit();
  return perFormDeposit;
});

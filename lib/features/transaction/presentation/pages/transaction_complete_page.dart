import 'package:bank_app/features/deposit/presentation/providers/deposit_provider.dart';
import 'package:bank_app/features/transaction/presentation/widgets/transaction_complete_widget.dart';
import 'package:bank_app/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:bank_app/shared/widgets/custom_app_bar.dart';
import 'package:bank_app/shared/widgets/error_widget.dart';
import 'package:bank_app/shared/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionCompletePage extends ConsumerWidget {
  const TransactionCompletePage({super.key, required this.isDeposit});

  final bool isDeposit;
  static const String route = 'transaction-complete';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var depositTransactionAsync = ref.watch(depositTransactionFutureProvider);
    var withdrawTransactionAsync = ref.watch(performWithDrawFutureProvider);
    var withdrawVM = ref.watch(withDrawVMProvider);
    var bankService = ref.watch(bankServiceProvider);
    var depositVM = ref.watch(depositVMProvider);
    return WillPopScope(
      onWillPop: () {
        if (isDeposit) {
          depositVM.resetDepositAmount();
          bankService.resetAccountSelection();
        } else {
          withdrawVM.resetWithDrawAmount();
          bankService.resetAccountSelection();
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Center(
          child: isDeposit
              ? depositTransactionAsync.when(
                  data: (data) {
                    return const TransactionComplete();
                  },
                  error: (error, stackTrace) {
                    return FlutterBankError(errorMsg: error.toString());
                  },
                  loading: () => const LoadingSpinner())
              : withdrawTransactionAsync.when(
                  data: (data) {
                    return const TransactionComplete();
                  },
                  error: (error, stackTrace) {
                    return FlutterBankError(errorMsg: error.toString());
                  },
                  loading: () => const LoadingSpinner()),
        ),
      ),
    );
  }
}

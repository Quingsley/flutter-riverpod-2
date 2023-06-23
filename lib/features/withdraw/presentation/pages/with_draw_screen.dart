import 'package:bank_app/features/auth/presenatation/widgets/flutter_bank_main_button.dart';
import 'package:bank_app/features/deposit/presentation/widgets/account_action_selection.dart';
import 'package:bank_app/features/deposit/presentation/widgets/account_deposit_slider.dart';
import 'package:bank_app/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:bank_app/shared/widgets/action_header.dart';
import 'package:bank_app/shared/widgets/custom_app_bar.dart';
import 'package:bank_app/shared/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WithdrawScreen extends ConsumerWidget {
  const WithdrawScreen({required this.transactionPath, super.key});

  final String transactionPath;

  static const String route = '/withdraw';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedAccount = ref.watch(bankServiceProvider).accountSelected;
    var amountToWithDraw = 0.0;
    var actualAmount = 0.0;
    if (selectedAccount != null) {
      amountToWithDraw = ref.watch(withdrawRepositoryProvider);
      actualAmount = amountToWithDraw > selectedAccount.balance!
          ? selectedAccount.balance!
          : amountToWithDraw;
    }
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const Drawer(
        child: FlutterBankDrawer(),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const AccountActionHeader(
                headerTitle: 'WithDraw', icon: Icons.logout),
            Expanded(
              child: AccountActionSelection(
                actionTypeLabel: 'From',
                amountChanger: AccountSlider(
                  sliderLabel: 'Amount to Withdraw',
                  sliderInitialValue: actualAmount,
                  sliderMaxValue:
                      selectedAccount != null ? selectedAccount.balance! : 0.0,
                  sliderAmountDisplay: actualAmount,
                  sliderOnChangeFunction: (value) {
                    ref
                        .read(withdrawRepositoryProvider.notifier)
                        .setAmountToWithdraw(value);
                  },
                ),
              ),
            ),
            FlutterBankMainButton(
              label: 'Make Withdrawal',
              onTap: () {
                //TODO: FIX
                StatefulNavigationShell.of(context)
                    .context
                    .push(transactionPath, extra: false);
              },
              enabled: ref
                  .read(withdrawRepositoryProvider.notifier)
                  .checkAmountToWithDraw(amountToWithDraw),
            )
          ],
        ),
      ),
    );
  }
}

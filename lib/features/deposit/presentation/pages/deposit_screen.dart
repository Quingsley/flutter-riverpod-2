import 'package:bank_app/features/auth/presenatation/widgets/flutter_bank_main_button.dart';
import 'package:bank_app/features/deposit/data/models/deposit_model.dart';
import 'package:bank_app/features/deposit/presentation/providers/deposit_provider.dart';
import 'package:bank_app/features/deposit/presentation/widgets/account_action_selection.dart';
import 'package:bank_app/features/deposit/presentation/widgets/account_deposit_slider.dart';
import 'package:bank_app/shared/widgets/action_header.dart';
import 'package:bank_app/shared/widgets/custom_app_bar.dart';
import 'package:bank_app/shared/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DepositScreen extends ConsumerWidget {
  const DepositScreen({required this.transactionPath, super.key});
  final String transactionPath;

  static const String route = '/deposit';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var amount = ref.watch(depositRepositoryProvider);
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
              headerTitle: 'Deposit',
              icon: Icons.login,
            ),
            Expanded(
              child: AccountActionSelection(
                actionTypeLabel: 'To',
                amountChanger: AccountSlider(
                  sliderLabel: 'Amount to Deposit',
                  sliderInitialValue: ref
                      .read(depositRepositoryProvider.notifier)
                      .amountToDeposit,
                  sliderAmountDisplay: ref.watch(depositRepositoryProvider),
                  sliderMaxValue: 1000,
                  sliderOnChangeFunction: (value) {
                    ref
                        .read(depositRepositoryProvider.notifier)
                        .setAmountToDepsosit(
                          DepositModel(
                            amount: value,
                          ),
                        );
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FlutterBankMainButton(
                  label: 'Make Deposit',
                  enabled: ref
                      .read(depositRepositoryProvider.notifier)
                      .checkAmountToDeposit(
                        DepositModel(amount: amount),
                      ),
                  onTap: () {
                    GoRouter.of(context).go(transactionPath, extra: true);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

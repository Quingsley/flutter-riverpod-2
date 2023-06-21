import 'package:bank_app/features/deposit/presentation/widgets/account_action_card.dart';
import 'package:bank_app/features/accounts/presentation/providers/account_provider.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:bank_app/shared/widgets/error_widget.dart';
import 'package:bank_app/shared/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountActionSelection extends ConsumerWidget {
  const AccountActionSelection({
    required this.actionTypeLabel,
    required this.amountChanger,
    super.key,
  });
  final String actionTypeLabel;
  final Widget amountChanger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var accountVM = ref.watch(userAccountFutureListProvider);
    //TODO: TAKE OUT THIS LOGIC TO THE FEATURES VIEWMODEL
    var depositService = ref.watch(bankServiceProvider);
    return accountVM.when(
        data: (data) {
          var accounts = data;
          var selectedAccount = depositService.accountSelected;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                actionTypeLabel,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              AccountActionCard(
                accounts: accounts,
              ),
              Visibility(
                visible: selectedAccount != null,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Current Balance',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 25,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            selectedAccount != null
                                ? '\$${selectedAccount.balance?.toStringAsFixed(2)}'
                                : '',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: amountChanger,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) =>
            FlutterBankError(errorMsg: error.toString()),
        loading: () => const LoadingSpinner());
  }
}

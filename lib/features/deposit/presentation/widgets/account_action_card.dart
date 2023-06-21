import 'package:bank_app/features/accounts/data/models/account_model.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountActionCard extends ConsumerWidget {
  const AccountActionCard({
    super.key,
    required this.accounts,
  });

  final List<Account?> accounts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: TAKE OUT THIS LOGIC TO THE FEATURES VIEWMODEL
    var depositService = ref.watch(bankServiceProvider);
    var selectedAccount = depositService.accountSelected;
    return Row(
      children: List.generate(
        accounts.length,
        (index) => Expanded(
          child: GestureDetector(
            onTap: () {
              depositService.setAccount = accounts[index];
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.inversePrimary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 20,
                    offset: const Offset(0.0, 5.0),
                  ),
                ],
                border: Border.all(
                  width: 5,
                  color: selectedAccount?.id == accounts[index]!.id
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${accounts[index]!.type!.toUpperCase()} ACCT',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  Text(accounts[index]!.accountNumber!)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

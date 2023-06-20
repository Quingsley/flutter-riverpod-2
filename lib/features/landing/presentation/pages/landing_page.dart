import 'package:bank_app/features/auth/presenatation/widgets/error_container.dart';
import 'package:bank_app/features/landing/data/models/account_model.dart';
import 'package:bank_app/features/landing/presentation/widgets/account_card.dart';
import 'package:bank_app/features/landing/presentation/providers/account_provider.dart';
import 'package:bank_app/shared/widgets/custom_app_bar.dart';
import 'package:bank_app/shared/widgets/loading_spinner.dart';
import 'package:bank_app/shared/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  static const String route = '/home';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var accountVM = ref.watch(userAccountFutureListProvider);
    return Scaffold(
      drawer: const Drawer(
        child: FlutterBankDrawer(),
      ),
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'My Accounts',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: accountVM.when(
                data: (data) {
                  List<Account> accounts = data;
                  if (accounts.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'You don\'t have any accounts\nassociated with your profile.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: accounts.length,
                      itemBuilder: (context, index) {
                        var acct = accounts[index];
                        return AccountCard(account: acct);
                      });
                },
                error: (error, stackTrace) =>
                    ErrorContainer(message: error.toString()),
                loading: () => const Center(
                  child: LoadingSpinner(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

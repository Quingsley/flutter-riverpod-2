import 'package:bank_app/features/tabs/presentation/widgets/create_account_modal.dart';
import 'package:bank_app/helpers/utils.dart';
import 'package:bank_app/shared/widgets/navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerWidget {
  const Home({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;
  static const String route = '/home';

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context)
            .colorScheme
            .inversePrimary, // Change this to the desired color
      ),
    );
    // var screens = ref.watch(screensProvider);
    // var currentTabIndex = ref.watch(selectedTabIndexProvider);
    // PageStorageBucket bucket = PageStorageBucket();
    // Widget currentScreen = screens[currentTabIndex];

    return SafeArea(
      child: Scaffold(
        // body: PageStorage(
        //   bucket: bucket,
        //   child: currentScreen,
        // ),
        body: navigationShell,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    elevation: 10,
                    clipBehavior: Clip.antiAlias,
                    child: const CreateBankAccountContainer(),
                  );
                });
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            Icons.savings,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BottomBarItem(
                      isSelected: navigationShell.currentIndex ==
                              StackRouteNames.accounts.index
                          ? true
                          : false,
                      icon: Icons.wallet,
                      title: 'Account',
                      onPress: () {
                        _goBranch(StackRouteNames.accounts.index);
                      },
                    ),
                    BottomBarItem(
                      icon: Icons.logout,
                      title: 'Withdraw',
                      onPress: () {
                        _goBranch(StackRouteNames.withdraw.index);
                      },
                      isSelected: navigationShell.currentIndex ==
                              StackRouteNames.withdraw.index
                          ? true
                          : false,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BottomBarItem(
                      icon: Icons.login,
                      title: 'Deposit',
                      onPress: () {
                        _goBranch(StackRouteNames.deposit.index);
                      },
                      isSelected: navigationShell.currentIndex ==
                              StackRouteNames.deposit.index
                          ? true
                          : false,
                    ),
                    BottomBarItem(
                        title: 'Expenses',
                        icon: Icons.payment,
                        isSelected: navigationShell.currentIndex ==
                                StackRouteNames.expenses.index
                            ? true
                            : false,
                        onPress: () {
                          _goBranch(StackRouteNames.expenses.index);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

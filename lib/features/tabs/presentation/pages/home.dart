import 'package:bank_app/features/tabs/presentation/widgets/create_account_modal.dart';
import 'package:bank_app/shared/widgets/navigation_bar_item.dart';
import 'package:bank_app/features/tabs/providers/tabs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  static const String route = '/home';

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
    var screens = ref.watch(screensProvider);
    var currentTabIndex = ref.watch(selectedTabIndexProvider);
    PageStorageBucket bucket = PageStorageBucket();
    Widget currentScreen = screens[currentTabIndex];

    return SafeArea(
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
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
                      isSelected: currentTabIndex == 0 ? true : false,
                      icon: Icons.wallet,
                      title: 'Account',
                      onPress: () {
                        currentScreen = screens[0];
                        ref.read(selectedTabIndexProvider.notifier).state = 0;
                      },
                    ),
                    BottomBarItem(
                      icon: Icons.logout,
                      title: 'Withdraw',
                      onPress: () {
                        currentScreen = screens[1];
                        ref.read(selectedTabIndexProvider.notifier).state = 1;
                      },
                      isSelected: currentTabIndex == 1 ? true : false,
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
                        currentScreen = screens[2];
                        ref.read(selectedTabIndexProvider.notifier).state = 2;
                      },
                      isSelected: currentTabIndex == 2 ? true : false,
                    ),
                    BottomBarItem(
                        title: 'Expenses',
                        icon: Icons.payment,
                        isSelected: currentTabIndex == 3 ? true : false,
                        onPress: () {
                          currentScreen = screens[3];
                          ref.read(selectedTabIndexProvider.notifier).state = 3;
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

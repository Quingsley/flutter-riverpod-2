import 'package:bank_app/features/auth/presenatation/pages/account_registration.dart';
import 'package:bank_app/features/auth/presenatation/pages/forget_password_page.dart';
import 'package:bank_app/features/deposit/presentation/pages/deposit_screen.dart';
import 'package:bank_app/features/error/presentation/pages/error_page.dart';
import 'package:bank_app/features/accounts/presentation/pages/accounts_page.dart';
import 'package:bank_app/features/auth/presenatation/pages/login_page.dart';
import 'package:bank_app/features/expenses/presentation/pages/expenses_screen.dart';
import 'package:bank_app/features/tabs/presentation/pages/home.dart';
import 'package:bank_app/features/transaction/presentation/pages/transaction_complete_page.dart';
import 'package:bank_app/features/withdraw/presentation/pages/with_draw_screen.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> mainNav =
      GlobalKey(debugLabel: 'mainNav');
  static final GlobalKey<NavigatorState> _shellNavigatorAccountsKey =
      GlobalKey<NavigatorState>(debugLabel: 'accounts');
  static final GlobalKey<NavigatorState> _shellNavigatorWithdrawKey =
      GlobalKey<NavigatorState>(debugLabel: 'withdraw');
  static final GlobalKey<NavigatorState> _shellNavigatorDepositKey =
      GlobalKey<NavigatorState>(debugLabel: 'deposit');
  static final GlobalKey<NavigatorState> _shellNavigatorExpensesKey =
      GlobalKey<NavigatorState>(debugLabel: 'expense');

  static final router = Provider<GoRouter>((ref) {
    final userState = ref.watch(firebaseAuthInstance);

    return GoRouter(
      navigatorKey: AppRoutes.mainNav,
      initialLocation:
          userState.currentUser != null ? Home.route : FlutterBankLogin.route,
      errorBuilder: (context, state) => ErrorPage(
        errorMessage: state.error.toString(),
      ),
      routes: [
        GoRoute(
          path: FlutterBankLogin.route,
          builder: (context, state) => const FlutterBankLogin(),
        ),
        GoRoute(
          path: FlutterAccountRegistration.route,
          builder: (context, state) => const FlutterAccountRegistration(),
        ),
        GoRoute(
          path: ForgetPasswordScreen.route,
          builder: (context, state) => const ForgetPasswordScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              Home(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              navigatorKey: AppRoutes._shellNavigatorAccountsKey,
              routes: [
                GoRoute(
                  path: AccountsPage.route,
                  builder: (context, state) => const AccountsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: AppRoutes._shellNavigatorWithdrawKey,
              routes: [
                GoRoute(
                  path: WithdrawScreen.route,
                  builder: (context, state) => const WithdrawScreen(
                    transactionPath: '/withdraw/transaction-complete',
                  ),
                  routes: [
                    GoRoute(
                      path: TransactionCompletePage.route,
                      parentNavigatorKey: AppRoutes._shellNavigatorWithdrawKey,
                      builder: (context, state) => TransactionCompletePage(
                        isDeposit: state.extra as bool,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: AppRoutes._shellNavigatorDepositKey,
              routes: [
                GoRoute(
                    path: DepositScreen.route,
                    builder: (context, state) => const DepositScreen(
                          transactionPath: '/deposit/transaction-complete',
                        ),
                    routes: [
                      GoRoute(
                        path: TransactionCompletePage.route,
                        parentNavigatorKey: AppRoutes._shellNavigatorDepositKey,
                        builder: (context, state) => TransactionCompletePage(
                          isDeposit: state.extra as bool,
                        ),
                      ),
                    ]),
              ],
            ),
            StatefulShellBranch(
                navigatorKey: AppRoutes._shellNavigatorExpensesKey,
                routes: [
                  GoRoute(
                    path: ExpensesScreen.route,
                    builder: (context, state) => const ExpensesScreen(),
                  ),
                ]),
          ],
        ),
      ],
    );
  });
}

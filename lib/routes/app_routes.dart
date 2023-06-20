import 'package:bank_app/features/auth/presenatation/pages/account_registration.dart';
import 'package:bank_app/features/auth/presenatation/pages/forget_password_page.dart';
import 'package:bank_app/features/deposit/presentation/pages/deposit_screen.dart';
import 'package:bank_app/features/error/presentation/pages/error_page.dart';
import 'package:bank_app/features/expenses/presentation/pages/expenses_screen.dart';
import 'package:bank_app/features/landing/presentation/pages/landing_page.dart';
import 'package:bank_app/features/auth/presenatation/pages/login_page.dart';
import 'package:bank_app/features/tabs/presentation/pages/home.dart';
import 'package:bank_app/features/transaction/presentation/pages/transaction_complete_page.dart';
import 'package:bank_app/features/withdraw/presentation/pages/with_draw_screen.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> mainNav = GlobalKey();
  static GlobalKey<NavigatorState> tabNav = GlobalKey();

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
        GoRoute(
          path: TransactionCompletePage.route,
          builder: (context, state) => TransactionCompletePage(
            isDeposit: state.extra as bool,
          ),
        ),
        ShellRoute(
          navigatorKey: AppRoutes.tabNav,
          builder: (context, state, child) {
            return const Home();
          },
          routes: [
            GoRoute(
              parentNavigatorKey: AppRoutes.tabNav,
              path: LandingPage.route,
              builder: (context, state) => const LandingPage(),
            ),
            GoRoute(
              parentNavigatorKey: AppRoutes.tabNav,
              path: WithdrawScreen.route,
              builder: (context, state) => const WithdrawScreen(),
            ),
            GoRoute(
              parentNavigatorKey: AppRoutes.tabNav,
              path: DepositScreen.route,
              builder: (context, state) => const DepositScreen(),
            ),
            GoRoute(
              parentNavigatorKey: AppRoutes.tabNav,
              path: ExpensesScreen.route,
              builder: (context, state) => const ExpensesScreen(),
            ),
          ],
        ),
      ],
    );
  });
}

import 'package:bank_app/routes/app_routes.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bank_app/features/auth/presenatation/pages/login_page.dart';

void signoutDialog(BuildContext context, WidgetRef ref) {
  final appContext = AppRoutes.mainNav.currentContext!;
  final authRepo = ref.read(authRepositoryProvider.notifier);
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            'Akiba Savings Bank Logout',
            style: TextStyle(
              color: Theme.of(ctx).colorScheme.primary,
            ),
          ),
          content: Container(
            padding: const EdgeInsets.all(20),
            child:
                const Text('Are you sure you want to logout of your account?'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await authRepo.signOut();
                if (appContext.mounted) {
                  GoRouter.of(appContext).go(FlutterBankLogin.route);
                }
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Theme.of(appContext).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      });
}

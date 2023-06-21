import 'package:bank_app/features/deposit/presentation/pages/deposit_screen.dart';
import 'package:bank_app/features/expenses/presentation/pages/expenses_screen.dart';
import 'package:bank_app/features/accounts/presentation/pages/accounts_page.dart';
import 'package:bank_app/features/tabs/presentation/viewmodels/tabs_view_model.dart';
import 'package:bank_app/features/withdraw/presentation/pages/with_draw_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedTabIndexProvider = StateProvider<int>((ref) => 0);

final screensProvider = StateProvider<List<Widget>>((ref) => const [
      AccountsPage(),
      WithdrawScreen(),
      DepositScreen(),
      ExpensesScreen(),
    ]);

final newAccountVMProvider =
    Provider<NewAccountViewModel>((ref) => NewAccountViewModel(ref));

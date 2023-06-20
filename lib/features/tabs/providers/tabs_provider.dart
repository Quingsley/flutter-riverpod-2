import 'package:bank_app/features/deposit/presentation/pages/deposit_screen.dart';
import 'package:bank_app/features/expenses/presentation/pages/expenses_screen.dart';
import 'package:bank_app/features/landing/presentation/pages/landing_page.dart';
import 'package:bank_app/features/withdraw/presentation/pages/with_draw_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedTabIndexProvider = StateProvider<int>((ref) => 0);

final screensProvider = StateProvider<List<Widget>>((ref) => const [
      LandingPage(),
      WithdrawScreen(),
      DepositScreen(),
      ExpensesScreen(),
    ]);

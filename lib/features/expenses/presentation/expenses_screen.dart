import 'package:bank_app/shared/widgets/custom_app_bar.dart';
import 'package:bank_app/shared/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  static const String route = '/expenses';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(
        child: FlutterBankDrawer(),
      ),
      body: Center(
        child: Text('Expenses'),
      ),
    );
  }
}

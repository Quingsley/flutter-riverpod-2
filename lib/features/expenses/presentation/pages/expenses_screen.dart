import 'package:bank_app/features/auth/presenatation/widgets/error_container.dart';
import 'package:bank_app/features/expenses/presentation/providers/expense_providers.dart';
import 'package:bank_app/features/expenses/presentation/widgets/create_expense_form.dart';
import 'package:bank_app/features/expenses/presentation/widgets/expense_card.dart';
import 'package:bank_app/features/expenses/presentation/widgets/no_expense_text.dart';
import 'package:bank_app/shared/widgets/action_header.dart';
import 'package:bank_app/shared/widgets/custom_app_bar.dart';
import 'package:bank_app/shared/widgets/flutter_bank_main_button.dart';
import 'package:bank_app/shared/widgets/loading_spinner.dart';
import 'package:bank_app/shared/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  static const String route = '/expenses';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var expenses = ref.watch(expenseStreamProvider);
    var expenseVM = ref.watch(expenseVMProvider);
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const Drawer(
        child: FlutterBankDrawer(),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AccountActionHeader(
              headerTitle: 'My Expenses',
              icon: Icons.payments,
            ),
            Expanded(
                child: expenses.when(
              data: (data) {
                if (data.isEmpty) {
                  return const FlutterBankNoExpenses();
                }
                return ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (BuildContext context, int index) {
                      return ExpenseCard(
                        expense: data[index],
                        onDeleteExpense: () {
                          expenseVM.deleteExpense(data[index].id!);
                        },
                      );
                    });
              },
              error: (error, stackTrace) =>
                  ErrorContainer(message: error.toString()),
              loading: () => const LoadingSpinner(),
            )),
            const SizedBox(
              height: 20,
            ),
            FlutterBankMainButton(
              label: 'Add Expense',
              onTap: () {
                // expenseVM.addExpense();
                Scaffold.of(context).showBottomSheet(
                  (context) => const ExpenseFormContainer(),
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                );
              },
              icon: Icons.add,
            )
          ],
        ),
      ),
    );
  }
}

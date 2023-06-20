import 'package:bank_app/features/expenses/data/models/expense_model.dart';
import 'package:bank_app/shared/providers/shared_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseViewModel {
  final Ref ref;

  ExpenseViewModel(this.ref);

  Stream<List<Expense>> getExpenses() {
    var expenseStream = ref.read(bankServiceProvider).getExpenses();
    return expenseStream;
  }

  void addExpense(Expense expense) {
    ref.read(bankServiceProvider).addExpense(expense);
  }

  void deleteExpense(String expenseId) {
    ref.read(bankServiceProvider).deleteExpense(expenseId);
  }
}

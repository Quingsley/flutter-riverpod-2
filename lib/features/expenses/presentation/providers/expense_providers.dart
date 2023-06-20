import 'package:bank_app/features/expenses/presentation/viewmodels/expense_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseVMProvider =
    Provider<ExpenseViewModel>((ref) => ExpenseViewModel(ref));

final expenseStreamProvider = StreamProvider.autoDispose((ref) {
  var expenseStream = ref.read(expenseVMProvider).getExpenses();
  return expenseStream;
});

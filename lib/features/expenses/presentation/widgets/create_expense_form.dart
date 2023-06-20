import 'package:bank_app/features/auth/presenatation/widgets/text_input.dart';
import 'package:bank_app/features/expenses/data/models/expense_model.dart';
import 'package:bank_app/features/expenses/presentation/providers/expense_providers.dart';
import 'package:bank_app/shared/widgets/flutter_bank_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseFormContainer extends ConsumerStatefulWidget {
  const ExpenseFormContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExpenseFormContainerState();
}

class _ExpenseFormContainerState extends ConsumerState<ExpenseFormContainer> {
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController datePickerValue = TextEditingController();
  FocusNode amountFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    amount.dispose();
    datePickerValue.dispose();
    amountFocusNode.dispose();
  }

  void _showDatePicker() async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025),
        helpText: 'Select Date');
    if (selectedDate != null) {
      datePickerValue.text = selectedDate.toIso8601String();
    }
  }

  @override
  Widget build(BuildContext context) {
    var expenseVM = ref.watch(expenseVMProvider);
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextInputField(
            controller: name,
            icon: Icons.abc,
            onChange: (value) {},
            hintText: 'Name',
            onSubmitted: (val) {
              amountFocusNode.requestFocus();
            },
          ),
          TextInputField(
            controller: amount,
            focusNode: amountFocusNode,
            icon: Icons.monetization_on,
            onChange: (value) {},
            hintText: 'Amount',
          ),
          FlutterBankMainButton(
            label: 'Pick a date',
            icon: Icons.date_range,
            onTap: () {
              _showDatePicker();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FlutterBankMainButton(
            label: 'Submit',
            onTap: () {
              expenseVM.addExpense(Expense(
                  name: name.value.text,
                  amount: int.tryParse(amount.value.text)!.toDouble(),
                  timeStamp: datePickerValue.value.text));

              name.clear();
              amount.clear();
              datePickerValue.clear();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

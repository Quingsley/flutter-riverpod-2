import 'package:bank_app/features/expenses/data/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(
      {required this.expense, required this.onDeleteExpense, super.key});
  final Expense expense;
  final Function() onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 15,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.name,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 12),
              ),
              Row(
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  Text(
                    '\$${expense.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat('dd/MM/yyyy')
                    .add_jm()
                    .format(DateTime.parse(expense.timeStamp)),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            child: IconButton(
              onPressed: onDeleteExpense,
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

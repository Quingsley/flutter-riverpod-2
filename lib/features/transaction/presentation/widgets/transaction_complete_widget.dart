import 'package:flutter/material.dart';

class TransactionComplete extends StatelessWidget {
  const TransactionComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_outline_outlined,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Transaction Completed',
          style: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.primary),
        )
      ],
    );
  }
}

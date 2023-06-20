import 'package:flutter/material.dart';

class FlutterBankNoExpenses extends StatelessWidget {
  const FlutterBankNoExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.payments,
            color: Theme.of(context).colorScheme.primary,
            size: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'There are no expenses\nat the moment',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}

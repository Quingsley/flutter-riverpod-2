import 'package:flutter/material.dart';

class FlutterBankError extends StatelessWidget {
  const FlutterBankError({super.key, required this.errorMsg});
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Errot fetching data: $errorMsg',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Text(
            'Please try agian',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

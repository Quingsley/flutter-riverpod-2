import 'package:flutter/material.dart';

class AccountActionHeader extends StatelessWidget {
  const AccountActionHeader(
      {super.key, required this.headerTitle, required this.icon});
  final String headerTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Row(children: [
        Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 10),
        Text(headerTitle,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            )),
      ]),
    );
  }
}

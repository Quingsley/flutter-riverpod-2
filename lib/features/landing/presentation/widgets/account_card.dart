import 'package:bank_app/features/landing/data/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key, required this.account});

  final Account account;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      height: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 5.0),
            blurRadius: 15,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                '${account.type?.toUpperCase()} ACCT',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text('****${account.accountNumber}'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balance',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.monetization_on,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    '\$${account.balance?.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 35,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              Text(
                'As of ${DateFormat('dd/MM/yyyy').add_jm().format(DateTime.now())}',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

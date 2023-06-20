class Account {
  final String? id;
  final String? type;
  final String? accountNumber;
  final double? balance;

  Account({this.id, this.type, this.accountNumber, this.balance});

  factory Account.fromJSON(Map<String, dynamic> data, String docId) {
    return Account(
      id: docId,
      type: data['type']!,
      accountNumber: data['account_number']!,
      balance: data['balance']!.toDouble(),
    );
  }
}

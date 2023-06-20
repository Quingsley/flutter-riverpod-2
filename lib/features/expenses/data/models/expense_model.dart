class Expense {
  final String name;
  final double amount;
  final String timeStamp;
  final String? id;

  Expense({
    required this.name,
    required this.amount,
    required this.timeStamp,
    this.id,
  });

  factory Expense.fromJson(Map<String, dynamic> data, String docId) {
    return Expense(
      name: data['name'],
      amount: data['amount'].toDouble(),
      timeStamp: data['timeStamp'],
      id: docId,
    );
  }
}

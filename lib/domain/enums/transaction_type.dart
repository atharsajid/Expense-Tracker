enum TransactionType {
  INCOME("Income"),
  EXPENSE("Expense");

  final String name;

  const TransactionType(this.name);

  @override
  String toString() => name;
}

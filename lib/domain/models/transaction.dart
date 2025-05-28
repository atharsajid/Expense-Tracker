import 'package:expense_tracker/domain/models/transaction_category.dart';

class Transaction {
  Transaction({
    required this.id,
    required this.date,
    required this.category,
    required this.type,
    required this.amount,
    required this.description,
  });

  final int? id;
  final DateTime? date;
  final TransactionCategory? category;
  final String? type;
  final num? amount;
  final String? description;

  factory Transaction.fromJson(Map json) {
    return Transaction(
      id: json["id"],
      date: DateTime.tryParse(json["date"] ?? ""),
      category: json["category"] == null ? null : TransactionCategory.fromJson(json["category"]),
      type: json["type"],
      amount: json["amount"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "category": category?.toJson(),
        "type": type,
        "amount": amount,
        "description": description,
      };
}

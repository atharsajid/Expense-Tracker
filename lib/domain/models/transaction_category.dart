class TransactionCategory {
  final String id;
  final String name;
  final String icon;

  TransactionCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory TransactionCategory.fromJson(Map json) {
    return TransactionCategory(
      id: json["id"],
      name: json["name"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}

extension StringExtensions on String? {
  /// Check both not null and not empty i.e. "".
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;
  bool get isNullOREmpty => this == null || this!.isEmpty || this == "null";

  
  /// Check both not null and not empty i.e. "" and also checks if equals to the parameter string in lower case
  bool isNotNullAndNotEmptyAndEquals(String? str) =>
      this != null && this!.isNotEmpty && this?.toLowerCase() == str?.toLowerCase();
}

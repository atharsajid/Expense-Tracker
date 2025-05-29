import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/extensions.dart/num_extensions.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:flutter/material.dart';

class CustomCategoryIndicatorWidget extends StatelessWidget {
  final Color? color;
  final String? title;
  const CustomCategoryIndicatorWidget({
    super.key,
    this.color,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: getSize(16),
          color: color,
        ),
        8.horizontalSpace,
        Text(
          title ?? "",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.lynch900),
        ),
      ],
    );
  }
}

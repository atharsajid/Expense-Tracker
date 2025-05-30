import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/domain/enums/transaction_type.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/utilities/app_helper.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/extensions.dart/date_time_extensions.dart';
import 'package:expense_tracker/utilities/extensions.dart/num_extensions.dart';
import 'package:expense_tracker/utilities/extensions.dart/string_extension.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:expense_tracker/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomTransactionTileWidget extends StatelessWidget {
  final Transaction? element;
  const CustomTransactionTileWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(all: 16),
      decoration: BoxDecoration(color: AppTheme.lightColor, borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(
          color: AppTheme.greyColor.withOpacity(0.05),
          blurRadius: 4,
          spreadRadius: 4,
          offset: const Offset(0, 4),
        ),
      ]),
      child: Row(
        children: [
          Container(
            height: getSize(40),
            width: getSize(40),
            padding: getPadding(all: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Helper.getCategoryColor(element?.category?.name),
                  Helper.getCategoryColor(element?.category?.name).withOpacity(0.3),
                ],
                transform: const GradientRotation(math.pi / -4),
              ),
            ),
            child: CustomImageView(
              imagePath: element?.category?.icon ?? AppImages.appLogo,
            ),
          ),
          7.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                element?.category?.name ?? "N/A",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.lynch900, fontSize: getFontSize(18)),
              ),
              Visibility(
                visible: element?.description?.isNotNullAndNotEmpty ?? false,
                child: SizedBox(
                  width: size.width * 0.45,
                  child: Text(
                    element?.description ?? "",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${element?.type == TransactionType.INCOME.name ? '+' : '-'}${element?.amount}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: element?.type == TransactionType.INCOME.name ? AppTheme.darkSuccessColor : AppTheme.errorColor,
                    ),
              ),
              Text(
                element?.date?.toFormatDateTime() ?? "-",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

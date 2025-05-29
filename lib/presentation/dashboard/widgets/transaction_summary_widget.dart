import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/domain/enums/transaction_type.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/presentation/dashboard/widgets/transaction_chart_widget.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/extensions.dart/num_extensions.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:expense_tracker/widgets/custom_category_indicator.dart';
import 'package:flutter/material.dart';

class TransactionSummaryWidget extends StatelessWidget {
  final DashboardController controller;
  final List<Transaction>? dataSource;
  const TransactionSummaryWidget({super.key, required this.controller, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.greyColor.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: getPadding(top: 24, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.transactionSummary,
                  style: AppTheme.customFontStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lynch900,
                  ),
                ),
              ],
            ),
          ),
          24.verticalSpace,
          Padding(
            padding: getPadding(left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomCategoryIndicatorWidget(
                      color: AppTheme.darkSuccessColor,
                      title: TransactionType.INCOME.name,
                    ),
                    12.horizontalSpace,
                    CustomCategoryIndicatorWidget(
                      color: AppTheme.errorColor,
                      title: TransactionType.EXPENSE.name,
                    ),
                    12.horizontalSpace,
                  ],
                ),
                4.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: getPadding(bottom: 30),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "${AppStrings.amount} (\$)",
                          style: AppTheme.customFontStyle(
                            fontSize: getFontSize(16),
                            fontWeight: FontWeight.w500,
                            color: AppTheme.greyColor,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        TransactionChartWidget(
                          dataSource: dataSource,
                        ),
                        Text(
                          AppStrings.date,
                          style: AppTheme.customFontStyle(
                            fontSize: getFontSize(16),
                            fontWeight: FontWeight.w500,
                            color: AppTheme.greyColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }
}

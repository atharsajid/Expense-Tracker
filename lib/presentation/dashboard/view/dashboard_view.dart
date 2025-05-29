import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/presentation/dashboard/widgets/transaction_summary_widget.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/extensions.dart/num_extensions.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:expense_tracker/widgets/custom_bottom_sheet.dart';
import 'package:expense_tracker/widgets/custom_image_view.dart';
import 'package:expense_tracker/widgets/custom_text_field_widget.dart';
import 'package:expense_tracker/widgets/dashboard_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  final List<Transaction> transactionList;

  const DashboardView({super.key, this.transactionList = const []});

  DashboardController get controller => Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    controller.init(transactionList);
    return GetBuilder(
        init: controller,
        builder: (_) {
          return ListView(
            padding: getPadding(left: 16, right: 16, bottom: 16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: size.width * 0.45,
                    child: CustomTextFieldWidget(
                      controller: controller.monthController,
                      isEnabled: false,
                      hintValue: AppStrings.thisMonth,
                      hintTextStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.grey300Color),
                      textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.lynch900),
                      prefixText: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: CustomImageView(
                          svgPath: AppImages.calendarSvg,
                          color: AppTheme.greyColor,
                        ),
                      ),
                      suffixIcon: Icons.keyboard_arrow_down,
                      showStaticBottomShadow: true,
                      onTap: () {
                        valueSelectionBottomSheet<String>(
                          context,
                          size: size,
                          headingText: AppStrings.selectMonth,
                          valueKey: "name",
                          selectedValue: controller.selectedMonth,
                          sheetHeight: 0.3,
                          filterList: ValueNotifier([AppStrings.thisMonth, AppStrings.lastMonth]),
                          onTap: (Object obj) {
                            controller.selectedMonth = obj as String;
                            controller.monthController.text = controller.selectedMonth;
                            controller.onMonthSelect();
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              DashboardCardWidget(
                totalSaving: controller.totalSaving,
                totalIncome: controller.totalIncome,
                totalExpense: controller.totalExpense,
              ),
              18.verticalSpace,
              TransactionSummaryWidget(
                controller: controller,
                dataSource: controller.transactionList,
              ),
            ],
          );
        });
  }
}

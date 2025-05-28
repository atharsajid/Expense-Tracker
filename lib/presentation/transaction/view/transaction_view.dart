import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/presentation/home/controller/home_view_controller.dart';
import 'package:expense_tracker/presentation/transaction/controller/transaction_controller.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/extensions.dart/num_extensions.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:expense_tracker/widgets/custom_filter_button.dart';
import 'package:expense_tracker/widgets/custom_image_view.dart';
import 'package:expense_tracker/widgets/custom_text_field_widget.dart';
import 'package:expense_tracker/widgets/custom_transaction_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  TransactionController get controller => Get.put(TransactionController());
  HomeViewController get homeController => Get.put(HomeViewController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Column(
            children: [
              Padding(
                padding: getPadding(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.transactions,
                      style: AppTheme.customFontStyle(color: AppTheme.lynch900, fontSize: getFontSize(24), fontWeight: FontWeight.bold),
                    ),
                    Obx(() {
                      final bool isSelected = controller.selectedCategory.value != null;
                      return CustomFilterButton(
                        size: const Size(34, 34),
                        bgColor: isSelected ? AppTheme.primaryColor : AppTheme.lightColor,
                        iconColor: isSelected ? AppTheme.lightColor : AppTheme.darkColor,
                        showBorder: !isSelected,
                        onTap: () {
                          onFilterIconTap(context, size, controller);
                        },
                      );
                    }),
                  ],
                ),
              ),
              18.verticalSpace,
              Obx(() {
                return Expanded(
                  child: ListView.separated(
                      itemCount: homeController.transactionList.length,
                      shrinkWrap: true,
                      padding: getPadding(left: 16, right: 16, top: 16, bottom: 32),
                      separatorBuilder: (context, index) {
                        return 12.verticalSpace;
                      },
                      itemBuilder: (context, index) {
                        Transaction element = homeController.transactionList[index];
                        return CustomTransactionTileWidget(
                          element: element,
                        );
                      }),
                );
              }),
            ],
          );
        });
  }

  onFilterIconTap(BuildContext context, Size size, TransactionController controller) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      backgroundColor: AppTheme.lightColor,
      context: context,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          maxChildSize: 0.65,
          expand: false,
          builder: (_, scrollController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(color: AppTheme.lightColor),
                  width: size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.45, vertical: 8.0),
                        child: const Divider(
                          color: AppTheme.grey300Color,
                          thickness: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(left: 12, right: 12),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      AppStrings.filterBy,
                      style: AppTheme.customFontStyle(
                        color: AppTheme.lynch900,
                        fontWeight: FontWeight.w500,
                        fontSize: getFontSize(20),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        AppStrings.applyFilter,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                      ),
                    ),
                  ]),
                ),
                12.verticalSpace,
                GetBuilder(
                    init: controller,
                    id: "date",
                    builder: (_) {
                      return Padding(
                        padding: getPadding(left: 12, right: 12),
                        child: CustomTextFieldWidget(
                          controller: controller.filterDateController,
                          isEnabled: false,
                          upperLabel: "Date(s)".tr,
                          hintValue: "Ex. 01 Jan, 2025".tr,
                          prefixText: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: CustomImageView(
                              svgPath: AppImages.calendarSvg,
                              color: AppTheme.greyColor,
                            ),
                          ),
                          suffixIcon: Icons.keyboard_arrow_down,
                          onTap: () async => await controller.onDateSelect(context),
                        ),
                      );
                    }),
                18.verticalSpace,
                Padding(
                  padding: getPadding(left: 12),
                  child: Text(
                    AppStrings.category,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppTheme.darkColor),
                  ),
                ),
                Expanded(
                    child: Visibility(
                  child: ListView.builder(
                      itemCount: controller.categoryFilterList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 3, bottom: 24),
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          bool isSelected = controller.selectedCategory.value == controller.categoryFilterList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: ListTile(
                                tileColor: isSelected ? AppTheme.selectedTileColor.withOpacity(0.2) : AppTheme.lightColor,
                                title: Text(
                                  controller.categoryFilterList[index].name,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.greyColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Visibility(
                                      visible: isSelected,
                                      child: const Icon(
                                        Icons.check,
                                        color: AppTheme.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                onTap: () {
                                  controller.selectedCategory.value = controller.categoryFilterList[index];
                                  Get.back();
                                }),
                          );
                        });
                      }),
                )),
              ],
            );
          },
        );
      },
    );
  }
}

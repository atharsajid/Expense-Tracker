import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/domain/enums/transaction_type.dart';
import 'package:expense_tracker/domain/models/transaction_category.dart';
import 'package:expense_tracker/presentation/add_transaction/controller/add_transaction_controller.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/extensions.dart/string_extension.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:expense_tracker/utilities/text_field_validators.dart';
import 'package:expense_tracker/widgets/custom_app_bar.dart';
import 'package:expense_tracker/widgets/custom_bottom_sheet.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:expense_tracker/widgets/custom_image_view.dart';
import 'package:expense_tracker/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddTransactionView extends StatelessWidget {
  const AddTransactionView({super.key});

  AddTransactionController get controller => Get.put(AddTransactionController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.addTransaction,
        showBackIcon: true,
        onBackIconPressed: () => Get.back(),
      ),
      backgroundColor: AppTheme.lightColor,
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            CustomTextFieldWidget(
              controller: controller.amountController,
              upperLabel: "Amount",
              asterisk: "\u{002A}",
              hintValue: "Enter Amount".tr,
              outerPaddingField: EdgeInsets.zero,
              prefixText: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      FittedBox(
                        child: Text(
                          "USD",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.greyColor),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppTheme.greyColor,
                      ),
                    ],
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                maxWidth: 75,
              ),
              showStaticBottomShadow: true,
              validator: (value) {
                if (value.isNullOREmpty) {
                  return "Required";
                }
                if (num.tryParse(value ?? "") == null) return "Invalid Amount";
                return null;
              },
              type: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter(RegExp(r'[0-9.]'), allow: true),
              ],
            ),
            CustomTextFieldWidget(
              controller: controller.categoryController,
              isEnabled: false,
              upperLabel: "Category".tr,
              asterisk: "\u{002A}",
              hintValue: "Select Category".tr,
              prefixText: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: CustomImageView(
                  svgPath: AppImages.gridSquareSvg,
                  color: AppTheme.greyColor,
                ),
              ),
              suffixIcon: Icons.keyboard_arrow_down,
              showStaticBottomShadow: true,
              validator: (value) => Validators.required(
                value,
              ),
              onTap: () {
                valueSelectionBottomSheet<TransactionCategory>(
                  context,
                  size: size,
                  headingText: "Select Category",
                  valueKey: "name",
                  selectedValue: null,
                  selectedValueID: controller.selectedCategory?.id ?? "",
                  sheetHeight: 0.5,
                  filterList: ValueNotifier(controller.categoryList),
                  onTap: (Object obj) {
                    controller.selectedCategory = obj as TransactionCategory?;
                    controller.categoryController.text = controller.selectedCategory?.name ?? "";
                    Get.back();
                  },
                );
              },
            ),
            CustomTextFieldWidget(
              controller: controller.typeController,
              isEnabled: false,
              upperLabel: "Type".tr,
              asterisk: "\u{002A}",
              hintValue: "Select Type".tr,
              prefixText: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: CustomImageView(
                  svgPath: AppImages.transactionTypeSvg,
                  color: AppTheme.greyColor,
                ),
              ),
              suffixIcon: Icons.keyboard_arrow_down,
              showStaticBottomShadow: true,
              validator: (value) => Validators.required(
                value,
              ),
              onTap: () {
                valueSelectionBottomSheet<TransactionType>(
                  context,
                  size: size,
                  headingText: "Select Type",
                  valueKey: "name",
                  selectedValue: controller.selectedTransactionType?.name,
                  sheetHeight: 0.3,
                  filterList: ValueNotifier(TransactionType.values),
                  onTap: (Object obj) {
                    controller.selectedTransactionType = obj as TransactionType?;
                    controller.typeController.text = controller.selectedTransactionType?.name ?? "";
                    Get.back();
                  },
                );
              },
            ),
            GetBuilder(
                init: controller,
                id: "date",
                builder: (_) {
                  return CustomTextFieldWidget(
                    controller: controller.dateController,
                    isEnabled: false,
                    upperLabel: "Select Date".tr,
                    asterisk: "\u{002A}",
                    hintValue: "Ex. 01 Jan, 2025".tr,
                    prefixText: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: CustomImageView(
                        svgPath: AppImages.calendarSvg,
                        color: AppTheme.greyColor,
                      ),
                    ),
                    suffixIcon: Icons.keyboard_arrow_down,
                    validator: (value) => Validators.required(
                      value,
                    ),
                    onTap: () async => await controller.onDateSelect(context),
                  );
                }),
            CustomTextFieldWidget(
              controller: controller.descriptionController,
              upperLabel: "Description".tr,
              hintValue: "Enter Description".tr,
              asterisk: "\u{002A}",
              maxLength: 250,
              minLines: 3,
              maxLines: 3,
              validator: (value) => Validators.required(
                value,
              ),
              textCapitalization: TextCapitalization.none,
              type: TextInputType.text,
              showStaticBottomShadow: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(
            margin: getMargin(left: 14, right: 14, top: 18, bottom: 34),
            borderRadius: 36,
            text: "Add Transaction".tr,
            showGradient: true,
            onTap: () {
              if (!controller.formKey.currentState!.validate()) {
                return;
              }
              controller.onAddTransaction();
            },
          ),
        ],
      ),
    );
  }
}

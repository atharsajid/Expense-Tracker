import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/presentation/home/controller/home_view_controller.dart';
import 'package:expense_tracker/routes/app_pages.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/widgets/custom_app_bar.dart';
import 'package:expense_tracker/widgets/custom_floation_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  HomeViewController get controller => Get.put(HomeViewController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar(
        isHome: true,
      ),
      backgroundColor: AppTheme.lightColor,
      body: Obx(() {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: controller.homeTabs[controller.currentTabIndex.value],
        );
      }),
      floatingActionButton: CustomFloatingActionButton(
        svgIcon: AppImages.addIconSvg,
        onPressed: () {
          Get.toNamed(Routes.ADD_TRANSACTION_SCREEN)?.then((value) {
            if (value is Transaction) {
              controller.transactionList.insert(0, value);
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.grey100Color.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 60,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomAppBar(
            height: 82,
            clipBehavior: Clip.antiAlias,
            notchMargin: 10,
            shape: const CircularNotchedRectangle(),
            color: AppTheme.lightColor,
            surfaceTintColor: AppTheme.lightColor,
            elevation: 12,
            child: SizedBox(
              height: 80,
              width: size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return IconButton(
                      onPressed: () {
                        controller.currentTabIndex.value = 0;
                      },
                      icon: buildSvgIconWidget(assetName: AppImages.gridSquareSvg, isSelected: controller.currentTabIndex.value == 0, height: 30),
                    );
                  }),
                  const Spacer(),
                  Obx(() {
                    return IconButton(
                      onPressed: () {
                        controller.currentTabIndex.value = 1;
                      },
                      icon: buildSvgIconWidget(assetName: AppImages.barChartSvg, isSelected: controller.currentTabIndex.value == 1),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSvgIconWidget({required String assetName, EdgeInsetsGeometry? padding, double? width, double? height, bool isSelected = false}) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: SvgPicture.asset(
            assetName,
            height: height,
            width: width,
            colorFilter: ColorFilter.mode(
              isSelected ? AppTheme.primaryColor : AppTheme.darkGreyColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          child: AnimatedContainer(
            width: isSelected ? 40 : 0,
            // height: 90,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.bottomCenter,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: const Divider(
              color: AppTheme.primaryColor,
              thickness: 2,
            ),
          ),
        ),
      ],
    );
  }
}

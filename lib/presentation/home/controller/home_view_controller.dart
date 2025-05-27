import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  final homeTabs = [
    Container(
      color: AppTheme.primaryColor,
    ),
    Container(
      color: AppTheme.secondaryColor,
    ),
  ];

  RxInt currentTabIndex = (0).obs;
}

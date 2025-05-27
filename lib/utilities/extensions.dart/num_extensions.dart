import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:flutter/material.dart';

extension NumExtension on num {
  ///Vertical Space
  Widget get verticalSpace => SizedBox(
        height: getSize(toDouble()),
      );

  ///Horizontal Space
  Widget get horizontalSpace => SizedBox(
        width: getSize(toDouble()),
      );
}

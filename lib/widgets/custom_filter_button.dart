import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CustomFilterButton extends StatelessWidget {
  final Color? bgColor;
  final Color? iconColor;
  final bool showBorder;
  final Size? size;
  final double? borderRadius;
  final void Function()? onTap;
  const CustomFilterButton({
    super.key,
    this.bgColor,
    this.iconColor,
    this.showBorder = true,
    this.size,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size?.height ?? 40,
        width: size?.width ?? 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor ?? AppTheme.lightColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          border: showBorder
              ? Border.all(
                  color: AppTheme.greyTextColor.withOpacity(0.7),
                )
              : null,
        ),
        child: CustomImageView(
          svgPath: AppImages.filterLinesSvg,
          color: iconColor ?? AppTheme.darkColor,
        ),
      ),
    );
  }
}

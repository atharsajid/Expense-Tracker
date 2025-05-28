import 'dart:math';

import 'package:expense_tracker/constants/app_constants.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.textFontSize = 16,
    this.textFontWeight = FontWeight.w500,
    this.fontFamily = AppConstants.appFont,
    this.boldText,
    this.enabled = true,
    this.visibility = true,
    this.textColor,
    this.bgColor,
    this.disabledColor,
    this.onTap,
    this.buttonWidth,
    this.height = 50,
    this.borderRadius = 50,
    this.textLeadingIcon,
    this.textTrailingIcon,
    this.width,
    this.minWidth = 0.0,
    this.margin,
    this.padding,
    this.maxLines,
    this.showGradient = false,
  });

  final String text;
  final double textFontSize;
  final FontWeight? textFontWeight;
  final String fontFamily;
  final String? boldText;
  final bool enabled;
  final bool visibility;
  final Color? textColor;
  final Color? bgColor;
  final Color? disabledColor;
  final void Function()? onTap;
  final double? buttonWidth;
  final double height;
  final double borderRadius;
  final Widget? textLeadingIcon;
  final Widget? textTrailingIcon;
  final double? width;
  final double minWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final bool showGradient;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Container(
        height: height,
        width: width,
        margin: margin ?? const EdgeInsetsDirectional.only(end: 10.0),
        alignment: Alignment.center,
        constraints: BoxConstraints(
          minWidth: minWidth,
          minHeight: height,
        ),
        decoration: BoxDecoration(
            border: showGradient
                ? null
                : Border.all(
                    color: enabled ? AppTheme.primaryColor : disabledColor ?? const Color(0xFFDEDEE1),
                  ),
            gradient: showGradient
                ? LinearGradient(
                    colors: AppTheme.primaryGradient,
                    transform: const GradientRotation(pi / 4),
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
            color: bgColor ?? (enabled ? AppTheme.primaryColor : disabledColor ?? const Color(0xFFDEDEE1))),
        child: MaterialButton(
          height: height,
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          onPressed: enabled ? onTap : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textLeadingIcon != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(end: 5),
                      child: textLeadingIcon,
                    )
                  : const SizedBox(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: text,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: textFontWeight,
                          fontSize: textFontSize,
                          fontFamily: fontFamily,
                          color: textColor ?? (enabled ? AppTheme.lightColor : AppTheme.greyTextColor)),
                    ),
                    if (boldText != null)
                      TextSpan(
                        text: boldText,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold, fontFamily: fontFamily, color: textColor ?? AppTheme.darkGreyColor),
                      ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
              ),
              textTrailingIcon ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

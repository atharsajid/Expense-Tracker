import 'package:expense_tracker/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utilities/app_theme.dart';

class EmptySpaceWidget extends StatelessWidget {
  const EmptySpaceWidget({
    super.key,
    required this.size,
    required this.text,
    this.textFontSize,
    this.titleText,
    this.bgColor,
    this.textColor = AppTheme.greyColor,
    this.height,
    this.imageHeight,
    this.textPadding,
    this.topSpace = 0,
  });

  final Size size;
  final String? titleText;
  final String text;
  final double? textFontSize;
  final Color? bgColor;
  final Color? textColor;
  final double? height;
  final double? imageHeight;
  final EdgeInsetsGeometry? textPadding;
  final double topSpace;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: bgColor ?? Colors.transparent,
      child: SizedBox(
        height: height ?? size.height / 3.2,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: topSpace,
            ),
            Flexible(
              child: SvgPicture.asset(
                AppImages.cloudZapSvgImage,
                height: imageHeight,
              ),
            ),
            Padding(
              padding:
                  textPadding ?? const EdgeInsets.only(top: 12.0, left: 40, right: 40, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (titleText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                      child: Text(
                        titleText!,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: textColor,
                          fontSize: textFontSize,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

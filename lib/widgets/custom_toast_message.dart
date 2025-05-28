import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CustomToastMessageWidget extends StatelessWidget {
  final String? heading;
  final String message;
  final Color bgColor;
  final Color textColor;
  final Color titleColor;
  final bool isError;
  final void Function()? onCancelPressed;
  const CustomToastMessageWidget({
    super.key,
    this.heading,
    required this.message,
    this.bgColor = AppTheme.lightColor,
    this.textColor = AppTheme.darkGreyColor,
    this.titleColor = AppTheme.grey900,
    this.isError = false,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppTheme.lightColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 4),
                color: AppTheme.grey900.withOpacity(0.1))
          ],
          border: Border.all(
            color: isError ? AppTheme.error100Color : AppTheme.success50,
          )),
      child: Stack(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.lightColor,
              image: const DecorationImage(
                alignment: Alignment.topLeft,
                image: AssetImage(
                  AppImages.bgRipplePatternImage,
                ),
                fit: BoxFit.none,
                scale: 1.62,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isError
                  ? AppTheme.error50Color.withOpacity(0.5)
                  : AppTheme.success50.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: isError ? AppTheme.error100Color : AppTheme.success50,
              child: CustomImageView(
                svgPath: isError ? AppImages.alertCircleSvg : AppImages.checkSvg,
                height: 24,
                color: isError ? AppTheme.errorColor : AppTheme.successColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(55, 6, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        heading ?? (isError ? "Error" : "Success"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: titleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    IconButton(
                      onPressed: onCancelPressed,
                      icon: const Icon(
                        Icons.close,
                        color: AppTheme.lynch900,
                        size: 20,
                      ),
                    )
                  ],
                ),
                Text(
                  message,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

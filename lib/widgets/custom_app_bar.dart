import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/extensions.dart/num_extensions.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:expense_tracker/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  final bool showBackIcon;
  final void Function()? onBackIconPressed;
  const CustomAppBar({
    super.key,
    this.isHome = false,
    this.showBackIcon = false,
    this.onBackIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: false,
      backgroundColor: AppTheme.lightColor,
      forceMaterialTransparency: true,
      surfaceTintColor: AppTheme.lightColor,
      elevation: 1,
      titleSpacing: getSize(showBackIcon ? 24 : 16),
      leading: showBackIcon
          ? IconButton(
              onPressed: onBackIconPressed,
              icon: const Icon(
                Icons.arrow_back,
                color: AppTheme.lynch900,
              ))
          : null,
      title: Visibility(
        visible: isHome,
        replacement: Text(
          AppStrings.appName,
          style: AppTheme.customFontStyle(
            color: AppTheme.lynch900,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Row(
          children: [
            CustomImageView(
              imagePath: AppImages.appLogo,
              height: getSize(36),
              width: getSize(36),
            ),
            8.horizontalSpace,
            Text(
              AppStrings.appName,
              style: AppTheme.customFontStyle(
                color: AppTheme.lynch900,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}

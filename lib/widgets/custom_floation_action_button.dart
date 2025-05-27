import 'dart:math';

import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String svgIcon;
  final void Function()? onPressed;
  const CustomFloatingActionButton({
    super.key,
    required this.svgIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppTheme.primaryGradient,
          transform: const GradientRotation(pi / 4),
        ),
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const CircleBorder(),
        child: SvgPicture.asset(
          svgIcon,
          height: 30,
          colorFilter: const ColorFilter.mode(
            AppTheme.lightColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

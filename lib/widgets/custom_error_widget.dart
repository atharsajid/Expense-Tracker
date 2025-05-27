import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.7),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber,
              color: AppTheme.warningColor,
              size: 60,
            ),
            const SizedBox(height: 20,),
            Center(
              child: Text(
                "Something went wrong.\nPlease try again",
                textAlign: TextAlign.center,
                style: AppTheme.customFontStyle(
                  color: AppTheme.darkGreyColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.6,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              )
            ),
          ],
        ),
      )
    );
  }
}
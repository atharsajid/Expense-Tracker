import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4aa2e0);

  static const Color secondaryColor = Color(0xFFca6ce6); //600

  static const Color baseColor = Color(0xFFf2e9ee);
  static const Color errorColor = Color(0xFFE22020);
  static const Color error50Color = Color(0xFFFEF3F2);
  static const Color error100Color = Color(0xFFFEE4E2);
  static const Color error500Color = Color(0xFFF04438);
  static const Color successColor = Color(0xFF28BF5B);
  static const Color darkSuccessColor = Color(0xFF079455);
  static const Color successColor700 = Color(0xFF1C8841);
  static const Color success50 = Color(0xFFECFDF3);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color accentColor = Color(0xFFf9b160);
  static const Color lightColor = Color(0xFFFFFFFF);
  static const Color lightGreyColor = Color(0xFFFFF7ED);
  static const Color greyColor = Color(0xFF70787D);
  static const Color grey300Color = Color(0xFFD0D5DD);
  static const Color grey200Color = Color(0xFFEAECF0);
  static const Color grey100Color = Color(0xFFECEEF2);
  static const Color greyTextColor = Color(0xFFA1A2A5);
  static const Color darkGreyColor = Color(0xFF475467);
  static const Color darkColor = Color(0xFF141218);
  static const Color darkColor2 = Color(0xFF222029);
  static const Color lynch900 = Color(0xff333947); //950
  static const Color darkColorLynch = Color(0xFF22252F); //950

  static const Color grey900 = Color(0xFF101828);

  static List<Color> primaryGradient = [
    primaryColor,
    secondaryColor,
    accentColor,
  ];

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: baseColor,
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: baseColor,
      error: error500Color,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: AppTheme.lightColor,
      backgroundColor: AppTheme.lightColor,
      modalBackgroundColor: AppTheme.lightColor,
    ),
    // canvasColor: AppTheme.lightColor,
    useMaterial3: true,
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        // height: lineHeight,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.2, //52px
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
        // height: 1,
      ),
      headlineLarge: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.2, //52px
          color: lightColor),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        // height: 1,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
        // height: 1,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        // height: 1,
      ),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: lightColor),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5, color: lightColor
          // height: 1.1,
          ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
        height: 1.4, //20px
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      ),
    ),
  );

  /// custom text-theme style
  static TextStyle customFontStyle({
    double fontSize = 16,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    double? lineHeight,
    double? letterSpacing,
    String? fontFamily = "Inter",
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          height: lineHeight,
          decoration: textDecoration,
          letterSpacing: letterSpacing,
          fontFamily: fontFamily);
}

import 'package:flutter/material.dart';

/// Дизайн-токены приложения — единый источник цветов и типографики,
/// чтобы все экраны регистрации выглядели последовательно.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF5A76); // основной коралл
  static const Color primaryDark = Color(0xFFE14C68);
  static const Color primarySoft = Color(0xFFFFE3E8);
  static const Color background = Color(0xFFFFF8F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2B2224);
  static const Color textSecondary = Color(0xFF9C8C8D);
  static const Color border = Color(0xFFF1E1DE);
  static const Color error = Color(0xFFE0455C);
  static const Color disabled = Color(0xFFF3E7E5);
  static const Color disabledText = Color(0xFFC9B9B8);
}

class AppText {
  AppText._();

  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle h2Small = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      background: AppColors.background,
    ),
    fontFamily: 'Roboto',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primarySoft,
      selectionHandleColor: AppColors.primary,
    ),
  );
}

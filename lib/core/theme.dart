import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary (trust blue like Stripe)
  static const primary = Color(0xFF2563EB);

  // Status
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFDC2626);

  // Backgrounds
  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;

  // Text
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);

  // Borders
  static const border = Color(0xFFE5E7EB);

  // Soft UI
  static const softBlue = Color(0xFFEFF6FF);
}

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
  static const xxxl = 64.0;
}

class AppRadius {
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const pill = 100.0;
}

class AppShadows {
  static List<BoxShadow> soft = [
    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
  ];

  static List<BoxShadow> medium = [
    BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8)),
  ];
}

class AppTextStyles {
  static const _base = TextStyle(fontFamily: 'Inter', color: AppColors.textPrimary);

  static const h1 = TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary);

  static const h2 = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  static const h3 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static const body = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textPrimary);

  static const caption = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary);

  static const small = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textTertiary);
}

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.success,
      error: AppColors.error,
      background: AppColors.background,
      surface: AppColors.surface,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.h3,
    ),

    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.h1,
      headlineMedium: AppTextStyles.h2,
      headlineSmall: AppTextStyles.h3,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.caption,
      bodySmall: AppTextStyles.small,
    ),
  );
}




//**
//
//Primary
//#2563EB

//Success
//#16A34A

//Warning
//#F59E0B

//Danger
//#DC2626

//Background
//#F8FAFC

//Cards
//White

//Border
//#E5E7EB
// */
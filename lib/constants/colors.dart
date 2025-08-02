import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color secondaryBlue = Color(0xFF3B82F6);
  static const Color successGreen = Color(0xFF059669);
  static const Color warningOrange = Color(0xFFF59E0B);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF8FAFC);
  static const Color mediumGray = Color(0xFFE5E7EB);
  static const Color darkGray = Color(0xFF374151);
  static const Color charcoal = Color(0xFF111827);

  // Template Colors
  static const Color template1 =
      Color(0xFF1E3A8A); // Professional blue template
  static const Color template2 = Color(0xFF059669); // Green template
  static const Color template3 = Color(0xFF7C3AED); // Purple template

  // Semantic Colors
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Background Colors
  static const Color primaryBackground = white;
  static const Color secondaryBackground = lightGray;
  static const Color cardBackground = white;

  // Text Colors
  static const Color primaryText = charcoal;
  static const Color secondaryText = darkGray;
  static const Color disabledText = Color(0xFF9CA3AF);

  // Border Colors
  static const Color primaryBorder = mediumGray;
  static const Color secondaryBorder = Color(0xFFD1D5DB);

  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, secondaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [successGreen, Color(0xFF10B981)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Material Color Scheme
  static MaterialColor get primarySwatch => MaterialColor(
        primaryBlue.value,
        <int, Color>{
          50: primaryBlue.withOpacity(0.1),
          100: primaryBlue.withOpacity(0.2),
          200: primaryBlue.withOpacity(0.3),
          300: primaryBlue.withOpacity(0.4),
          400: primaryBlue.withOpacity(0.5),
          500: primaryBlue,
          600: primaryBlue.withOpacity(0.7),
          700: primaryBlue.withOpacity(0.8),
          800: primaryBlue.withOpacity(0.9),
          900: primaryBlue,
        },
      );
}

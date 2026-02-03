import 'package:flutter/material.dart';
import 'design_tokens.dart';

/// Application theme configuration
/// Provides light and dark themes with proper color schemes and styles
class AppTheme {
  AppTheme._();

  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF0097EE);
  static const Color _lightSecondary = Color(0xFF03DAC6);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightBackground = Color(0xFFF5F5F5);
  static const Color _lightError = Color(0xFFB00020);
  static const Color _lightOnPrimary = Color(0xFFFFFFFF);
  static const Color _lightOnSecondary = Color(0xFF000000);
  static const Color _lightOnSurface = Color(0xFF000000);
  static const Color _lightOnBackground = Color(0xFF000000);
  static const Color _lightOnError = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFFBB86FC);
  static const Color _darkSecondary = Color(0xFF03DAC6);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkError = Color(0xFFCF6679);
  static const Color _darkOnPrimary = Color(0xFF000000);
  static const Color _darkOnSecondary = Color(0xFF000000);
  static const Color _darkOnSurface = Color(0xFFFFFFFF);
  static const Color _darkOnBackground = Color(0xFFFFFFFF);
  static const Color _darkOnError = Color(0xFF000000);

  // Favorite/Star Colors
  static const Color favoriteActiveLight = Color(0xFFFFC107); // Amber
  static const Color favoriteInactiveLight = Color(0xFF757575); // Grey
  static const Color favoriteActiveDark = Color(0xFFFFD54F); // Light Amber
  static const Color favoriteInactiveDark = Color(0xFF9E9E9E); // Light Grey

  /// Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: _lightPrimary,
        onPrimary: _lightOnPrimary,
        secondary: _lightSecondary,
        onSecondary: _lightOnSecondary,
        error: _lightError,
        onError: _lightOnError,
        surface: _lightSurface,
        onSurface: _lightOnSurface,
      ),
      scaffoldBackgroundColor: _lightBackground,
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: DesignTokens.cardElevationLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.cornerRadius),
        ),
        color: _lightSurface,
        shadowColor: Colors.black.withOpacity(0.2),
        surfaceTintColor: Colors.transparent,
      ),

      // Text Theme
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: DesignTokens.nameFontSize,
          fontWeight: FontWeight.w600,
          color: _lightOnSurface,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          fontSize: DesignTokens.statusFontSize,
          fontWeight: FontWeight.w400,
          color: Color(0xFF666666),
          letterSpacing: 0.05,
        ),
        titleLarge: TextStyle(
          fontSize: DesignTokens.emptyStateTitleSize,
          fontWeight: FontWeight.bold,
          color: _lightOnBackground,
        ),
        bodyMedium: TextStyle(
          fontSize: DesignTokens.emptyStateMessageSize,
          color: Color(0xFF666666),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: _lightOnSurface,
        size: DesignTokens.favoriteIconSize,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightPrimary,
        foregroundColor: _lightOnPrimary,
        elevation: 4,
        centerTitle: true,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _lightPrimary,
      ),
    );
  }

  /// Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: _darkPrimary,
        onPrimary: _darkOnPrimary,
        secondary: _darkSecondary,
        onSecondary: _darkOnSecondary,
        error: _darkError,
        onError: _darkOnError,
        surface: _darkSurface,
        onSurface: _darkOnSurface,
      ),
      scaffoldBackgroundColor: _darkBackground,
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: DesignTokens.cardElevationDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.cornerRadius),
        ),
        color: _darkSurface,
        shadowColor: Colors.black.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
      ),

      // Text Theme
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: DesignTokens.nameFontSize,
          fontWeight: FontWeight.w600,
          color: _darkOnSurface,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          fontSize: DesignTokens.statusFontSize,
          fontWeight: FontWeight.w400,
          color: Color(0xFFB0B0B0),
          letterSpacing: 0.05,
        ),
        titleLarge: TextStyle(
          fontSize: DesignTokens.emptyStateTitleSize,
          fontWeight: FontWeight.bold,
          color: _darkOnBackground,
        ),
        bodyMedium: TextStyle(
          fontSize: DesignTokens.emptyStateMessageSize,
          color: Color(0xFFB0B0B0),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: _darkOnSurface,
        size: DesignTokens.favoriteIconSize,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkSurface,
        foregroundColor: _darkOnSurface,
        elevation: 2,
        centerTitle: true,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _darkPrimary,
      ),
    );
  }

  /// Get favorite icon color based on theme and state
  static Color getFavoriteColor(BuildContext context, bool isFavorite) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (isFavorite) {
      return isDark ? favoriteActiveDark : favoriteActiveLight;
    } else {
      return isDark ? favoriteInactiveDark : favoriteInactiveLight;
    }
  }

  /// Get overlay gradient for image text readability
  static LinearGradient getImageOverlayGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        (isDark ? Colors.black : Colors.black87).withOpacity(
          DesignTokens.overlayOpacityEnd,
        ),
      ],
      stops: const [
        1 - DesignTokens.overlayGradientHeight,
        1.0,
      ],
    );
  }
}
/// Design tokens for the application
/// Contains all design constants used across the app
class DesignTokens {
  DesignTokens._();

  // Corner Radius
  static const double cornerRadius = 12.0;
  static const double cornerRadiusSmall = 8.0;
  static const double cornerRadiusLarge = 16.0;

  // Card Elevation
  static const double cardElevationLight = 6.0;
  static const double cardElevationDark = 2.0;

  // Overlay Gradient
  static const double overlayGradientHeight = 0.4; // 40% of image height

  // Icon Sizes
  static const double favoriteIconSize = 22.0;
  static const double errorIconSize = 48.0;

  // Font Sizes
  static const double nameFontSize = 13.0;
  static const double statusFontSize = 11.0;
  static const double emptyStateTitleSize = 20.0;
  static const double emptyStateMessageSize = 14.0;

  // Spacing
  static const double gridPadding = 16.0;
  static const double gridSpacing = 12.0;
  static const double cardInternalPadding = 8.0;
  static const double cardImageTopPadding = 8.0;

  // Grid Layout
  static const double childAspectRatioSingleColumn = 1.2;
  static const double childAspectRatioTwoColumns = 0.85;
  static const double childAspectRatioThreeColumns = 0.75;

  // Animation Durations
  static const Duration favoriteAnimationDuration = Duration(milliseconds: 200);
  static const Duration themeTransitionDuration = Duration(milliseconds: 300);

  // Image
  static const double imageWidthFactor = 0.9;
  static const double loaderSize = 50.0;

  // Opacity
  static const double overlayOpacityStart = 0.0;
  static const double overlayOpacityEnd = 0.8;

  // Contrast ratios for accessibility (WCAG AA)
  static const double minimumContrastRatio = 4.5;
  static const double minimumLargeTextContrastRatio = 3.0;
}
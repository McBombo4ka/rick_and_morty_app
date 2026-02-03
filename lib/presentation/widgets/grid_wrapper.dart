import 'package:flutter/material.dart';
import '../themes/design_tokens.dart';

/// Wrapper for character grid that provides proper spacing and padding
/// This wrapper can be used around CharacterGrid to add spacing without modifying the original widget
class GridWrapper extends StatelessWidget {
  const GridWrapper({
    super.key,
    required this.child,
    this.crossAxisCount = 2,
  });

  final Widget child;
  final int crossAxisCount;

  /// Get appropriate aspect ratio based on column count
  double get childAspectRatio {
    switch (crossAxisCount) {
      case 1:
        return DesignTokens.childAspectRatioSingleColumn;
      case 2:
        return DesignTokens.childAspectRatioTwoColumns;
      case 3:
        return DesignTokens.childAspectRatioThreeColumns;
      default:
        return DesignTokens.childAspectRatioTwoColumns;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.gridPadding),
      child: child,
    );
  }
}

/// Helper class to provide grid parameters based on layout
class GridParameters {
  const GridParameters({
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  /// Create grid parameters based on column count
  factory GridParameters.fromColumnCount(int columnCount) {
    double aspectRatio;
    switch (columnCount) {
      case 1:
        aspectRatio = DesignTokens.childAspectRatioSingleColumn;
        break;
      case 2:
        aspectRatio = DesignTokens.childAspectRatioTwoColumns;
        break;
      case 3:
        aspectRatio = DesignTokens.childAspectRatioThreeColumns;
        break;
      default:
        aspectRatio = DesignTokens.childAspectRatioTwoColumns;
    }

    return GridParameters(
      crossAxisCount: columnCount,
      childAspectRatio: aspectRatio,
      crossAxisSpacing: DesignTokens.gridSpacing,
      mainAxisSpacing: DesignTokens.gridSpacing,
    );
  }
}

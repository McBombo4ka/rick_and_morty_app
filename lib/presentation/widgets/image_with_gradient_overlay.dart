import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../themes/design_tokens.dart';

/// Image widget with gradient overlay for better text readability
/// Wraps CachedNetworkImage with a gradient overlay
class ImageWithGradientOverlay extends StatelessWidget {
  const ImageWithGradientOverlay({
    super.key,
    required this.imageUrl,
    required this.width,
    this.semanticLabel,
  });

  final String imageUrl;
  final double width;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? 'Character image',
      image: true,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.cornerRadius),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              fit: BoxFit.cover,
              cacheKey: imageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: SizedBox(
                  width: DesignTokens.loaderSize,
                  height: DesignTokens.loaderSize,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 3,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: width,
                height: width,
                color: Theme.of(context).colorScheme.surface,
                child: Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error,
                  size: DesignTokens.errorIconSize,
                  semanticLabel: 'Failed to load image',
                ),
              ),
            ),
            // Gradient overlay for text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.getImageOverlayGradient(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
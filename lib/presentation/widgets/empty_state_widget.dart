import 'package:flutter/material.dart';
import '../themes/design_tokens.dart';

/// Empty state widget shown when no characters are available
/// Can be used for initial empty state or when filters return no results
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.icon = Icons.person_search,
    this.title = 'No Characters Found',
    this.message = 'Try adjusting your filters or pull to refresh',
    this.onActionPressed,
    this.actionLabel,
  });

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: '$title. $message',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: theme.colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (onActionPressed != null && actionLabel != null) ...[
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: onActionPressed,
                  icon: const Icon(Icons.refresh),
                  label: Text(actionLabel!),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DesignTokens.cornerRadiusSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Error state widget for displaying errors with retry option
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.error_outline,
      title: 'Oops! Something went wrong',
      message: message,
      actionLabel: 'Retry',
      onActionPressed: onRetry,
    );
  }
}
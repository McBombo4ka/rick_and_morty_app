import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../themes/design_tokens.dart';

class AnimatedFavoriteButton extends StatefulWidget {
  const AnimatedFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
    this.size = DesignTokens.favoriteIconSize,
  });

  final bool isFavorite;
  final VoidCallback onPressed;
  final double size;

  @override
  State<AnimatedFavoriteButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: DesignTokens.favoriteAnimationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(AnimatedFavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite && widget.isFavorite) {
      _playAnimation();
    }
  }

  void _playAnimation() {
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.getFavoriteColor(context, widget.isFavorite);

    return Semantics(
      label: widget.isFavorite ? 'Remove from favorites' : 'Add to favorites',
      button: true,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: IconButton(
          onPressed: widget.onPressed,
          icon: Icon(
            widget.isFavorite ? Icons.star : Icons.star_border_outlined,
            color: color,
            size: widget.size,
            shadows: [
              BoxShadow(
                color: widget.isFavorite ? Colors.yellow : Colors.black,
                spreadRadius: 10,
                blurRadius: 10,
              ),
            ],
          ),
          tooltip: widget.isFavorite
              ? 'Remove from favorites'
              : 'Add to favorites',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}

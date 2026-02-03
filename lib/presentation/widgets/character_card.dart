import 'package:flutter/material.dart';
import '../../presentation/bloc/favorites_cubit/favorites_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/character.dart';
import '../themes/design_tokens.dart';
import 'animated_favorite_button.dart';
import 'image_with_gradient_overlay.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
    this.onFavoritePressed,
  });

  final Character character;
  final VoidCallback? onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RepaintBoundary(
      child: Semantics(
        label: 'Character card: ${character.name}, ${character.status}',
        child: Card(
          // Card styling is handled by theme
          child: Stack(
            children: [
              Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        // Image with gradient overlay
                        SizedBox(
                          width:
                              constraints.maxWidth *
                              DesignTokens.imageWidthFactor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: DesignTokens.cardImageTopPadding,
                            ),
                            child: ImageWithGradientOverlay(
                              imageUrl: character.imageURL,
                              width:
                                  constraints.maxWidth *
                                  DesignTokens.imageWidthFactor,
                              semanticLabel: '${character.name} image',
                            ),
                          ),
                        ),
      
                        // Name
                        SizedBox(
                          width:
                              constraints.maxWidth *
                              DesignTokens.imageWidthFactor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DesignTokens.cardInternalPadding,
                              vertical: 4,
                            ),
                            child: Text(
                              character.name,
                              style: theme.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
      
                        // Status
                        Text(character.status, style: theme.textTheme.bodySmall),
                      ],
                    );
                  },
                ),
              ),
      
              // Animated favorite button
              Positioned(
                right: -10,
                top: -5,
                child: BlocBuilder<FavoritesCubit, List<Character>>(
                  builder: (context, favorites) {
                    final isFavorite = favorites.any((fav) => fav.id == character.id);
                    return RepaintBoundary(
                      child: AnimatedFavoriteButton(
                        isFavorite: isFavorite,
                        onPressed: onFavoritePressed ?? () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

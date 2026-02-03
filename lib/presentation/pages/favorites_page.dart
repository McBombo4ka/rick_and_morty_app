import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/character.dart';
import '../bloc/favorites_cubit/favorites_cubit.dart';
import '../widgets/character_card.dart';
import '../widgets/empty_state_widget.dart';

class FavoritesPages extends StatelessWidget {
  const FavoritesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Избранное')),
        body: BlocBuilder<FavoritesCubit, List<Character>>(
          builder: (context, favorites) {
            if (favorites.isEmpty) {
              return EmptyStateWidget(
                icon: Icons.star_border,
                title: 'Пока нет избранных',
                message: 'Добавьте персонажей в избранное, нажав на звёздочку',
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final ch = favorites[index];
                return CharacterCard(
                  character: ch,
                  onFavoritePressed: () {
                    context.read<FavoritesCubit>().toggle(ch.id);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

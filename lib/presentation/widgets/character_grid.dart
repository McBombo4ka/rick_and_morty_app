import 'package:flutter/material.dart';
import '../../presentation/widgets/character_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_bloc/character_bloc.dart';
import '../bloc/favorites_cubit/favorites_cubit.dart';
import '../bloc/layout_bloc/cubit/layout_cubit.dart';

class CharacterGrid extends StatefulWidget {
  const CharacterGrid({super.key});

  @override
  State<CharacterGrid> createState() => _CharacterGridState();
}

class _CharacterGridState extends State<CharacterGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<CharacterBloc>().add(LoadCharacters());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterBloc, CharacterState>(
      listener: (context, state) {
        if (state is CharacterLoaded && state.paginationError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.paginationError!),
              action: SnackBarAction(
                label: 'Повторить',
                onPressed: () {
                  context.read<CharacterBloc>().add(LoadCharacters());
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CharacterLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CharacterError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ошибка: ${state.message}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<CharacterBloc>().add(LoadCharacters());
                  },
                  child: const Text('Повторить'),
                ),
              ],
            ),
          );
        }

        if (state is CharacterLoaded) {
          return BlocBuilder<LayoutCubit, int>(
            builder: (context, crossAxisCount) {
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.7,
                ),
                // +1 для индикатора загрузки
                itemCount:
                    state.characters.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  // Показываем индикатор загрузки в конце
                  if (index == state.characters.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return CharacterCard(
                    character: state.characters[index],
                    onFavoritePressed: () {
                      context.read<FavoritesCubit>().toggle(
                        state.characters[index].id,
                      );
                    },
                  );
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

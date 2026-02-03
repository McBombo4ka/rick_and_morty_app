import 'package:flutter/material.dart';
import '../../presentation/widgets/grid_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_bloc/character_bloc.dart';
import '../bloc/layout_bloc/cubit/layout_cubit.dart';
import '../bloc/theme_cubit/theme_cubit.dart';
import '../widgets/character_grid.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/icons/three_colums_icon.dart';
import '../widgets/icons/two_columns_icon.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Row(
              children: [
                const Text('Characters'),
                const Spacer(),
                IconButton(
                  onPressed: () => context.read<LayoutCubit>().setColumns(2),
                  icon: const TwoColumnsIcon(size: 20),
                  tooltip: 'Two columns',
                ),
                IconButton(
                  onPressed: () => context.read<LayoutCubit>().setColumns(3),
                  icon: const ThreeColumnsIcon(size: 20),
                  tooltip: 'Three columns',
                ),
                IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  onPressed: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  tooltip: 'Toggle theme',
                ),
              ],
            ),
          ),
          BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {
              if (state is CharacterInitial || state is CharacterLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is CharacterLoaded && state.characters.isEmpty) {
                return SliverToBoxAdapter(
                  child: EmptyStateWidget(
                    icon: Icons.person_search,
                    title: 'No Characters Found',
                    message: 'Pull to refresh or check your connection',
                    actionLabel: 'Retry',
                    onActionPressed: () {
                      context.read<CharacterBloc>().add(LoadCharacters());
                    },
                  ),
                );
              } else if (state is CharacterLoaded) {
                return SliverFillRemaining(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: RefreshIndicator(
                      edgeOffset: 0,
                      onRefresh: () async {
                        context.read<CharacterBloc>().add(ReloadCharacters());
                      },
                      child: GridWrapper(child: CharacterGrid()),
                    ),
                  ),
                );
              } else {
                return const SliverFillRemaining(child: SizedBox());
              }
            },
          ),
        ],
      ),
    );
  }
}

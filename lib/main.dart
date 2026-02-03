import 'package:flutter/material.dart';
import '../presentation/bloc/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';
import 'presentation/bloc/character_bloc/character_bloc.dart';
import 'presentation/bloc/favorites_cubit/favorites_cubit.dart';
import 'presentation/bloc/layout_bloc/cubit/layout_cubit.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetIt();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CharacterBloc>()..add(LoadCharacters()),
        ),
        BlocProvider(create: (_) => getIt<LayoutCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<FavoritesCubit>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (_, mode) {
        return MaterialApp(
          themeMode: mode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const HomePage(),
        );
      },
    );
  }
}


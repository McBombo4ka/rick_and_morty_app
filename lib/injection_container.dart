import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/sources/local/character_local_sources.dart';
import 'data/sources/remote/character_remote_source.dart';
import 'data/models/character_model.dart'; // Импортируйте вашу модель
import '../data/repositories/character_repository_implement.dart';
import '../domain/usecases/get_character.dart';
import '../domain/repositories/character_repository.dart';
import 'presentation/bloc/character_bloc/character_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/network/network_info.dart';
import 'presentation/bloc/favorites_cubit/favorites_cubit.dart';
import 'presentation/bloc/layout_bloc/cubit/layout_cubit.dart';
import 'presentation/bloc/theme_cubit/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  // Инициализация Hive
  await Hive.initFlutter();

  // Регистрация адаптера (если используете TypeAdapter)
  Hive.registerAdapter(CharacterModelAdapter());

  // Открытие Box
  final characterBox = await Hive.openBox<CharacterModel>('characters');

  // Регистрация Box в GetIt
  getIt.registerLazySingleton<Box<CharacterModel>>(() => characterBox);

  final settingsBox = await Hive.openBox('settings');

  // Box для всех настроек
  getIt.registerLazySingleton<Box>(() => settingsBox);

  // ThemeCubit с Hive
  getIt.registerFactory(() => ThemeCubit(getIt<Box>()));

  // LayoutCubit с Hive
  getIt.registerFactory(() => LayoutCubit(getIt<Box>()));

  getIt.registerLazySingleton(() => Connectivity());

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // Dio
  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 1),
        receiveTimeout: const Duration(seconds: 1),
        sendTimeout: const Duration(seconds: 1),
      ),
    ),
  );

  // Remote datasource
  getIt.registerLazySingleton<CharacterRemoteSource>(
    () => CharacterRemoteSource(dio: getIt()),
  );

  // Local datasource
  getIt.registerLazySingleton<CharacterLocalSource>(
    () => CharacterLocalSourceImplement(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImplement(
      remote: getIt(),
      local: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use case
  getIt.registerLazySingleton(() => GetCharacterUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => CharacterBloc(getIt(), localSource: getIt(), networkInfo: getIt()),
  );

  // FavoritesCubit
  getIt.registerFactory(() => FavoritesCubit(getIt()));
}

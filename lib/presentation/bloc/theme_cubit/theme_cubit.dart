import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Cubit for managing application theme mode with Hive persistence
class ThemeCubit extends Cubit<ThemeMode> {
  final Box box;

  ThemeCubit(this.box) : super(_loadTheme(box));

  /// Load theme from Hive, default to system
  static ThemeMode _loadTheme(Box box) {
    final v = box.get('theme', defaultValue: 2); // 0: light, 1: dark, 2: system
    return ThemeMode.values[v];
  }

  /// Save current theme to Hive
  void _saveTheme(ThemeMode mode) {
    box.put('theme', mode.index);
  }

  /// Set specific theme
  void setTheme(ThemeMode mode) {
    _saveTheme(mode);
    emit(mode);
  }

  /// Toggle between light and dark
  void toggleTheme() {
    ThemeMode next;
    if (state == ThemeMode.light) {
      next = ThemeMode.dark;
    } else if (state == ThemeMode.dark) {
      next = ThemeMode.light;
    } else {
      next = ThemeMode.light; // system -> light
    }
    setTheme(next);
  }

  void setLightTheme() => setTheme(ThemeMode.light);
  void setDarkTheme() => setTheme(ThemeMode.dark);
  void setSystemTheme() => setTheme(ThemeMode.system);

  bool get isLight => state == ThemeMode.light;
  bool get isDark => state == ThemeMode.dark;
  bool get isSystem => state == ThemeMode.system;
}

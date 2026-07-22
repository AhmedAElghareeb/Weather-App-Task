import 'package:base_structure/src/core/helpers/prefs_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String _themeModeKey = 'theme_mode';

/// Cubit

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  Future<void> init() async {
    final savedThemeMode = CacheStorage.read(_themeModeKey);
    if (savedThemeMode != null) {
      final themeMode = savedThemeMode == 'dark'
          ? ThemeMode.dark
          : ThemeMode.light;
      emit(state.copyWith(themeMode: themeMode));
    }
  }

  Future<void> toggleTheme() async {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    await CacheStorage.write(
      _themeModeKey,
      newThemeMode == ThemeMode.dark ? 'dark' : 'light',
    );

    emit(state.copyWith(themeMode: newThemeMode));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await CacheStorage.write(
      _themeModeKey,
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
    emit(state.copyWith(themeMode: mode));
  }

  bool get isDarkMode => state.themeMode == ThemeMode.dark;
}

/// State

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  factory ThemeState.initial() {
    return const ThemeState(themeMode: ThemeMode.light);
  }

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object?> get props => [themeMode];
}

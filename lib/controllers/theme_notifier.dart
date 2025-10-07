import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tribbe/core/providers/storage_providers.dart';
import 'package:tribbe/core/services/user_storage_service.dart';

/// Estado del tema
class ThemeState {
  final ThemeMode themeMode;
  final bool isLoading;

  const ThemeState({required this.themeMode, this.isLoading = false});

  ThemeState copyWith({ThemeMode? themeMode, bool? isLoading}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  String get themeModeName {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Día';
      case ThemeMode.dark:
        return 'Noche';
      case ThemeMode.system:
        return 'Sistema';
    }
  }
}

/// Notifier para el tema
class ThemeNotifier extends StateNotifier<ThemeState> {
  final UserStorageService _storageService;

  ThemeNotifier(this._storageService)
    : super(const ThemeState(themeMode: ThemeMode.system)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = _storageService.getTheme();
    if (savedTheme != null) {
      final themeMode = _getThemeModeFromString(savedTheme);
      state = state.copyWith(themeMode: themeMode);
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(isLoading: true);
    await _storageService.saveTheme(_getStringFromThemeMode(themeMode));
    state = state.copyWith(themeMode: themeMode, isLoading: false);
  }

  Future<void> toggleTheme() async {
    final newMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    await setThemeMode(newMode);
  }

  ThemeMode _getThemeModeFromString(String theme) {
    switch (theme) {
      case 'Día':
        return ThemeMode.light;
      case 'Noche':
        return ThemeMode.dark;
      case 'Sistema':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  String _getStringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Día';
      case ThemeMode.dark:
        return 'Noche';
      case ThemeMode.system:
        return 'Sistema';
    }
  }
}

/// Provider para el controlador del tema
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((
  ref,
) {
  final storageService = ref.watch(userStorageServiceProvider);
  return ThemeNotifier(storageService);
});

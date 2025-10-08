import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribbe/core/di/injection_container.dart';
import 'package:tribbe/core/services/user_storage_service.dart';

/// Controller para el tema
class ThemeController extends GetxController {
  final UserStorageService _storageService = getIt<UserStorageService>();

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  final RxBool _isLoading = false.obs;

  ThemeMode get themeMode => _themeMode.value;
  bool get isLoading => _isLoading.value;

  bool get isDarkMode {
    if (_themeMode.value == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode.value == ThemeMode.dark;
  }

  String get themeModeName {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return 'Día';
      case ThemeMode.dark:
        return 'Noche';
      case ThemeMode.system:
        return 'Sistema';
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = _storageService.getTheme();
    if (savedTheme != null) {
      final themeMode = _getThemeModeFromString(savedTheme);
      _themeMode.value = themeMode;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    _isLoading.value = true;
    await _storageService.saveTheme(_getStringFromThemeMode(themeMode));
    _themeMode.value = themeMode;
    _isLoading.value = false;
  }

  Future<void> toggleTheme() async {
    final newMode = _themeMode.value == ThemeMode.light
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribbe/core/di/injection_container.dart';
import 'package:tribbe/core/services/user_storage_service.dart';

/// Controller para el idioma
class LanguageController extends GetxController {
  final UserStorageService _storageService = getIt<UserStorageService>();

  final Rx<Locale> _locale = const Locale('es').obs;
  final RxBool _isLoading = false.obs;

  Locale get locale => _locale.value;
  bool get isLoading => _isLoading.value;

  String get languageName {
    switch (_locale.value.languageCode) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      default:
        return 'Español';
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final savedLanguage = _storageService.getLanguage();
    if (savedLanguage != null) {
      final locale = _getLocaleFromString(savedLanguage);
      _locale.value = locale;
    }
  }

  Future<void> setLanguage(String language) async {
    _isLoading.value = true;
    await _storageService.saveLanguage(language);
    final locale = _getLocaleFromString(language);
    _locale.value = locale;
    _isLoading.value = false;
  }

  Future<void> setLocale(Locale locale) async {
    _isLoading.value = true;
    final language = _getStringFromLocale(locale);
    await _storageService.saveLanguage(language);
    _locale.value = locale;
    _isLoading.value = false;
  }

  Locale _getLocaleFromString(String language) {
    switch (language) {
      case 'Español':
        return const Locale('es');
      case 'English':
        return const Locale('en');
      default:
        return const Locale('es');
    }
  }

  String _getStringFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      default:
        return 'Español';
    }
  }
}

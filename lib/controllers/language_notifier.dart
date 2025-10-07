import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tribbe/core/providers/storage_providers.dart';
import 'package:tribbe/core/services/user_storage_service.dart';

/// Estado del idioma
class LanguageState {
  final Locale locale;
  final bool isLoading;

  const LanguageState({required this.locale, this.isLoading = false});

  LanguageState copyWith({Locale? locale, bool? isLoading}) {
    return LanguageState(
      locale: locale ?? this.locale,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  String get languageName {
    switch (locale.languageCode) {
      case 'es':
        return 'Español';
      default:
        return 'Español';
    }
  }
}

/// Notifier para el idioma
class LanguageNotifier extends StateNotifier<LanguageState> {
  final UserStorageService _storageService;

  LanguageNotifier(this._storageService)
    : super(const LanguageState(locale: Locale('es'))) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final savedLanguage = _storageService.getLanguage();
    if (savedLanguage != null) {
      final locale = _getLocaleFromString(savedLanguage);
      state = state.copyWith(locale: locale);
    }
  }

  Future<void> setLanguage(String language) async {
    state = state.copyWith(isLoading: true);
    await _storageService.saveLanguage(language);
    final locale = _getLocaleFromString(language);
    state = state.copyWith(locale: locale, isLoading: false);
  }

  Future<void> setLocale(Locale locale) async {
    state = state.copyWith(isLoading: true);
    final language = _getStringFromLocale(locale);
    await _storageService.saveLanguage(language);
    state = state.copyWith(locale: locale, isLoading: false);
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

/// Provider para el controlador del idioma
final languageNotifierProvider =
    StateNotifierProvider<LanguageNotifier, LanguageState>((ref) {
      final storageService = ref.watch(userStorageServiceProvider);
      return LanguageNotifier(storageService);
    });

import 'package:tribbe/core/services/storage_service.dart';
import 'package:tribbe/models/user_profile_model.dart';

/// Servicio para gestionar el almacenamiento del perfil de usuario
class UserStorageService {
  final StorageService _storageService;

  UserStorageService(this._storageService);

  static const String _userProfileKey = 'user_profile';
  static const String _themeKey = 'theme_preference';
  static const String _languageKey = 'language_preference';
  static const String _genderKey = 'gender_preference';

  /// Guardar perfil de usuario completo
  Future<bool> saveUserProfile(UserProfileModel profile) async {
    return await _storageService.saveJson(
      key: _userProfileKey,
      value: profile.toJson(),
    );
  }

  /// Obtener perfil de usuario
  UserProfileModel? getUserProfile() {
    final json = _storageService.getJson(_userProfileKey);
    if (json == null) return null;
    return UserProfileModel.fromJson(json);
  }

  /// Guardar preferencia de tema
  Future<bool> saveTheme(String theme) async {
    return await _storageService.saveString(key: _themeKey, value: theme);
  }

  /// Obtener preferencia de tema
  String? getTheme() {
    return _storageService.getString(_themeKey);
  }

  /// Guardar preferencia de idioma
  Future<bool> saveLanguage(String language) async {
    return await _storageService.saveString(key: _languageKey, value: language);
  }

  /// Obtener preferencia de idioma
  String? getLanguage() {
    return _storageService.getString(_languageKey);
  }

  /// Guardar preferencia de género
  Future<bool> saveGender(String gender) async {
    return await _storageService.saveString(key: _genderKey, value: gender);
  }

  /// Obtener preferencia de género
  String? getGender() {
    return _storageService.getString(_genderKey);
  }

  /// Eliminar perfil de usuario
  Future<bool> deleteUserProfile() async {
    return await _storageService.remove(_userProfileKey);
  }

  /// Limpiar todas las preferencias del usuario
  Future<void> clearAllUserData() async {
    await _storageService.remove(_userProfileKey);
    await _storageService.remove(_themeKey);
    await _storageService.remove(_languageKey);
    await _storageService.remove(_genderKey);
  }

  /// Verificar si existe perfil de usuario
  bool hasUserProfile() {
    return _storageService.hasKey(_userProfileKey);
  }
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Servicio para gestionar el almacenamiento local con SharedPreferences
class StorageService {
  late final SharedPreferences _prefs;
  bool _initialized = false;

  bool get isInitialized => _initialized;

  /// Inicializar el servicio de almacenamiento
  Future<void> initialize() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  /// Guardar un string
  Future<bool> saveString({required String key, required String value}) async {
    _ensureInitialized();
    return await _prefs.setString(key, value);
  }

  /// Obtener un string
  String? getString(String key) {
    _ensureInitialized();
    return _prefs.getString(key);
  }

  /// Guardar un int
  Future<bool> saveInt({required String key, required int value}) async {
    _ensureInitialized();
    return await _prefs.setInt(key, value);
  }

  /// Obtener un int
  int? getInt(String key) {
    _ensureInitialized();
    return _prefs.getInt(key);
  }

  /// Guardar un bool
  Future<bool> saveBool({required String key, required bool value}) async {
    _ensureInitialized();
    return await _prefs.setBool(key, value);
  }

  /// Obtener un bool
  bool? getBool(String key) {
    _ensureInitialized();
    return _prefs.getBool(key);
  }

  /// Guardar un double
  Future<bool> saveDouble({required String key, required double value}) async {
    _ensureInitialized();
    return await _prefs.setDouble(key, value);
  }

  /// Obtener un double
  double? getDouble(String key) {
    _ensureInitialized();
    return _prefs.getDouble(key);
  }

  /// Guardar un objeto JSON
  Future<bool> saveJson({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    _ensureInitialized();
    final jsonString = json.encode(value);
    return await _prefs.setString(key, jsonString);
  }

  /// Obtener un objeto JSON
  Map<String, dynamic>? getJson(String key) {
    _ensureInitialized();
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  /// Guardar una lista de strings
  Future<bool> saveStringList({
    required String key,
    required List<String> value,
  }) async {
    _ensureInitialized();
    return await _prefs.setStringList(key, value);
  }

  /// Obtener una lista de strings
  List<String>? getStringList(String key) {
    _ensureInitialized();
    return _prefs.getStringList(key);
  }

  /// Eliminar un valor
  Future<bool> remove(String key) async {
    _ensureInitialized();
    return await _prefs.remove(key);
  }

  /// Limpiar todos los datos
  Future<bool> clearAll() async {
    _ensureInitialized();
    return await _prefs.clear();
  }

  /// Verificar si existe una key
  bool hasKey(String key) {
    _ensureInitialized();
    return _prefs.containsKey(key);
  }

  /// Obtener todas las keys
  Set<String> getAllKeys() {
    _ensureInitialized();
    return _prefs.getKeys();
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'StorageService no está inicializado. Llama a initialize() primero.',
      );
    }
  }
}

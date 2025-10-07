import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribbe/core/di/injection_container.dart';
import 'package:tribbe/core/services/storage_service.dart';
import 'package:tribbe/core/services/user_storage_service.dart';

/// Provider para el servicio de almacenamiento
final storageServiceProvider = Provider<StorageService>((ref) {
  return getIt<StorageService>();
});

/// Provider para el servicio de almacenamiento de usuario
final userStorageServiceProvider = Provider<UserStorageService>((ref) {
  return getIt<UserStorageService>();
});

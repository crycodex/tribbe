import 'package:get_it/get_it.dart';
import 'package:tribbe/core/services/storage_service.dart';
import 'package:tribbe/core/services/user_storage_service.dart';
import 'package:tribbe/services/firebase_service.dart';

final getIt = GetIt.instance;

/// Configurar inyección de dependencias
Future<void> setupDependencyInjection() async {
  // Servicios de almacenamiento
  final storageService = StorageService();
  await storageService.initialize();
  getIt.registerSingleton<StorageService>(storageService);

  getIt.registerSingleton<UserStorageService>(
    UserStorageService(getIt<StorageService>()),
  );

  // Firebase service
  getIt.registerSingleton<FirebaseService>(FirebaseService());
}

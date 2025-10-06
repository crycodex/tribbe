import 'package:firebase_auth/firebase_auth.dart';
import 'package:tribbe/models/user_model.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream para escuchar cambios en el estado de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Usuario actual
  User? get currentUser => _auth.currentUser;

  // Verificar si está autenticado
  bool get isAuthenticated => currentUser != null;

  // Obtener modelo de usuario actual
  UserModel? get currentUserModel {
    final user = currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  // Iniciar sesión con email y contraseña
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Registrar usuario con email y contraseña
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  // Actualizar perfil de usuario
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      final user = currentUser;
      if (user != null) {
        await user.updateDisplayName(displayName);
        await user.updatePhotoURL(photoURL);
        await user.reload();
      }
    } catch (e) {
      throw Exception('Error al actualizar perfil: $e');
    }
  }

  // Enviar email de verificación
  Future<void> sendEmailVerification() async {
    try {
      final user = currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      throw Exception('Error al enviar email de verificación: $e');
    }
  }

  // Enviar email de restablecimiento de contraseña
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _handleAuthException(e as FirebaseAuthException);
    }
  }

  // Manejar excepciones de Firebase Auth
  Exception _handleAuthException(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No se encontró una cuenta con este email.';
        break;
      case 'wrong-password':
        message = 'Contraseña incorrecta.';
        break;
      case 'email-already-in-use':
        message = 'Ya existe una cuenta con este email.';
        break;
      case 'weak-password':
        message = 'La contraseña es muy débil.';
        break;
      case 'invalid-email':
        message = 'El email no es válido.';
        break;
      case 'user-disabled':
        message = 'Esta cuenta ha sido deshabilitada.';
        break;
      case 'too-many-requests':
        message = 'Demasiados intentos. Intenta más tarde.';
        break;
      case 'network-request-failed':
        message = 'Error de conexión. Verifica tu internet.';
        break;
      default:
        message = 'Error de autenticación: ${e.message}';
    }
    return Exception(message);
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tribbe/models/auth_state.dart';
import 'package:tribbe/models/user_model.dart';
import 'package:tribbe/services/firebase_service.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  final Rx<AuthState> _state = const AuthState.initial().obs;
  late StreamSubscription<User?> _authSubscription;

  AuthState get state => _state.value;
  bool get isAuthenticated => _state.value.isAuthenticated;
  bool get isLoading => _state.value.isLoading;
  UserModel? get user => _state.value.user;
  String? get errorMessage => _state.value.errorMessage;
  String? get successMessage => _state.value.successMessage;

  @override
  void onInit() {
    super.onInit();
    _authSubscription = _firebaseService.authStateChanges.listen(
      _onAuthStateChanged,
      onError: _onAuthError,
    );
  }

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      final userModel = UserModel.fromFirebaseUser(firebaseUser);
      _state.value = AuthState.authenticated(userModel);
    } else {
      _state.value = const AuthState.unauthenticated();
    }
  }

  void _onAuthError(Object error) {
    _state.value = AuthState.error(error.toString());
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _state.value = const AuthState.loading();

      await _firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      _state.value = AuthState.error(e.toString());
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _state.value = const AuthState.loading();

      await _firebaseService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      _state.value = AuthState.error(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      _state.value = const AuthState.loading();

      await _firebaseService.signOut();
    } catch (e) {
      _state.value = AuthState.error(e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseService.sendPasswordResetEmail(email);
    } catch (e) {
      _state.value = AuthState.error(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _state.value = const AuthState.loading();

      await _firebaseService.sendPasswordResetEmail(email);

      _state.value = _state.value.copyWith(
        successMessage:
            'Se ha enviado un enlace de restablecimiento a tu email',
        isLoading: false,
      );
    } catch (e) {
      _state.value = AuthState.error(e.toString());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _firebaseService.sendEmailVerification();
    } catch (e) {
      _state.value = AuthState.error(e.toString());
    }
  }

  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      _state.value = const AuthState.loading();

      await _firebaseService.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
    } catch (e) {
      _state.value = AuthState.error(e.toString());
    }
  }

  void clearError() {
    if (_state.value.hasError) {
      _state.value = _state.value.copyWith(errorMessage: null);
    }
  }

  void clearSuccess() {
    if (_state.value.successMessage != null) {
      _state.value = _state.value.copyWith(successMessage: null);
    }
  }

  @override
  void onClose() {
    _authSubscription.cancel();
    super.onClose();
  }
}

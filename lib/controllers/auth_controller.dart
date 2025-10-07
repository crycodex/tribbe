import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tribbe/models/auth_state.dart';
import 'package:tribbe/models/user_model.dart';
import 'package:tribbe/services/firebase_service.dart';

class AuthController extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  AuthState _state = const AuthState.initial();
  late StreamSubscription<User?> _authSubscription;

  AuthState get state => _state;
  bool get isAuthenticated => _state.isAuthenticated;
  bool get isLoading => _state.isLoading;
  UserModel? get user => _state.user;
  String? get errorMessage => _state.errorMessage;
  String? get successMessage => _state.successMessage;

  AuthController() {
    _init();
  }

  void _init() {
    _authSubscription = _firebaseService.authStateChanges.listen(
      _onAuthStateChanged,
      onError: _onAuthError,
    );
  }

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      final userModel = UserModel.fromFirebaseUser(firebaseUser);
      _state = AuthState.authenticated(userModel);
    } else {
      _state = const AuthState.unauthenticated();
    }
    notifyListeners();
  }

  void _onAuthError(Object error) {
    _state = AuthState.error(error.toString());
    notifyListeners();
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _state = const AuthState.loading();
      notifyListeners();

      await _firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _state = const AuthState.loading();
      notifyListeners();

      await _firebaseService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      _state = const AuthState.loading();
      notifyListeners();

      await _firebaseService.signOut();
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseService.sendPasswordResetEmail(email);
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _state = const AuthState.loading();
      notifyListeners();

      await _firebaseService.sendPasswordResetEmail(email);

      _state = _state.copyWith(
        successMessage:
            'Se ha enviado un enlace de restablecimiento a tu email',
        isLoading: false,
      );
      notifyListeners();
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _firebaseService.sendEmailVerification();
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      _state = const AuthState.loading();
      notifyListeners();

      await _firebaseService.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  void clearError() {
    if (_state.hasError) {
      _state = _state.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  void clearSuccess() {
    if (_state.successMessage != null) {
      _state = _state.copyWith(successMessage: null);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}

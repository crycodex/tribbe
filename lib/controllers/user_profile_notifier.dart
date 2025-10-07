import 'package:flutter_riverpod/legacy.dart';
import 'package:tribbe/core/providers/storage_providers.dart';
import 'package:tribbe/core/services/user_storage_service.dart';
import 'package:tribbe/models/user_profile_model.dart';

/// Estado del perfil de usuario
class UserProfileState {
  final UserProfileModel? profile;
  final bool isLoading;
  final String? errorMessage;

  const UserProfileState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
  });

  UserProfileState copyWith({
    UserProfileModel? profile,
    bool? isLoading,
    String? errorMessage,
  }) {
    return UserProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  bool get hasProfile => profile != null;
}

/// Notifier para el perfil de usuario
class UserProfileNotifier extends StateNotifier<UserProfileState> {
  final UserStorageService _storageService;

  UserProfileNotifier(this._storageService) : super(const UserProfileState()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      final profile = _storageService.getUserProfile();
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> saveProfile(UserProfileModel profile) async {
    state = state.copyWith(isLoading: true);
    try {
      await _storageService.saveUserProfile(profile);
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> updateProfile(UserProfileModel profile) async {
    await saveProfile(profile);
  }

  Future<void> deleteProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      await _storageService.deleteUserProfile();
      state = const UserProfileState();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> clearAllData() async {
    state = state.copyWith(isLoading: true);
    try {
      await _storageService.clearAllUserData();
      state = const UserProfileState();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }
}

/// Provider para el controlador del perfil de usuario
final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfileState>((ref) {
      final storageService = ref.watch(userStorageServiceProvider);
      return UserProfileNotifier(storageService);
    });

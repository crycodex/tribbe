import 'package:get/get.dart';
import 'package:tribbe/core/di/injection_container.dart';
import 'package:tribbe/core/services/user_storage_service.dart';
import 'package:tribbe/models/user_profile_model.dart';

/// Controller para el perfil de usuario
class UserProfileController extends GetxController {
  final UserStorageService _storageService = getIt<UserStorageService>();

  final Rxn<UserProfileModel> _profile = Rxn<UserProfileModel>();
  final RxBool _isLoading = false.obs;
  final RxnString _errorMessage = RxnString();

  UserProfileModel? get profile => _profile.value;
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;
  bool get hasProfile => _profile.value != null;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _isLoading.value = true;
    try {
      final profile = _storageService.getUserProfile();
      _profile.value = profile;
      _isLoading.value = false;
    } catch (e) {
      _errorMessage.value = e.toString();
      _isLoading.value = false;
    }
  }

  Future<void> saveProfile(UserProfileModel profile) async {
    _isLoading.value = true;
    try {
      await _storageService.saveUserProfile(profile);
      _profile.value = profile;
      _isLoading.value = false;
    } catch (e) {
      _errorMessage.value = e.toString();
      _isLoading.value = false;
    }
  }

  Future<void> updateProfile(UserProfileModel profile) async {
    await saveProfile(profile);
  }

  Future<void> deleteProfile() async {
    _isLoading.value = true;
    try {
      await _storageService.deleteUserProfile();
      _profile.value = null;
      _isLoading.value = false;
    } catch (e) {
      _errorMessage.value = e.toString();
      _isLoading.value = false;
    }
  }

  Future<void> clearAllData() async {
    _isLoading.value = true;
    try {
      await _storageService.clearAllUserData();
      _profile.value = null;
      _isLoading.value = false;
    } catch (e) {
      _errorMessage.value = e.toString();
      _isLoading.value = false;
    }
  }

  void clearError() {
    if (_errorMessage.value != null) {
      _errorMessage.value = null;
    }
  }
}

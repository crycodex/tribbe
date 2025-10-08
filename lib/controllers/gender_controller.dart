import 'package:get/get.dart';
import 'package:tribbe/core/di/injection_container.dart';
import 'package:tribbe/core/services/user_storage_service.dart';

/// Controller para el género
class GenderController extends GetxController {
  final UserStorageService _storageService = getIt<UserStorageService>();

  final RxString _gender = 'Masculino'.obs;
  final RxBool _isLoading = false.obs;

  String get gender => _gender.value;
  bool get isLoading => _isLoading.value;
  bool get isMale => _gender.value == 'Masculino';
  bool get isFemale => _gender.value == 'Femenino';

  @override
  void onInit() {
    super.onInit();
    _loadGender();
  }

  Future<void> _loadGender() async {
    final savedGender = _storageService.getGender();
    if (savedGender != null) {
      _gender.value = savedGender;
    }
  }

  Future<void> setGender(String gender) async {
    _isLoading.value = true;
    await _storageService.saveGender(gender);
    _gender.value = gender;
    _isLoading.value = false;
  }

  Future<void> toggleGender() async {
    final newGender = isMale ? 'Femenino' : 'Masculino';
    await setGender(newGender);
  }
}

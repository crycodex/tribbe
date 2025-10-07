import 'package:flutter_riverpod/legacy.dart';
import 'package:tribbe/core/providers/storage_providers.dart';
import 'package:tribbe/core/services/user_storage_service.dart';

/// Estado del género
class GenderState {
  final String gender;
  final bool isLoading;

  const GenderState({required this.gender, this.isLoading = false});

  GenderState copyWith({String? gender, bool? isLoading}) {
    return GenderState(
      gender: gender ?? this.gender,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isMale => gender == 'Masculino';
  bool get isFemale => gender == 'Femenino';
}

/// Notifier para el género
class GenderNotifier extends StateNotifier<GenderState> {
  final UserStorageService _storageService;

  GenderNotifier(this._storageService)
    : super(const GenderState(gender: 'Masculino')) {
    _loadGender();
  }

  Future<void> _loadGender() async {
    final savedGender = _storageService.getGender();
    if (savedGender != null) {
      state = state.copyWith(gender: savedGender);
    }
  }

  Future<void> setGender(String gender) async {
    state = state.copyWith(isLoading: true);
    await _storageService.saveGender(gender);
    state = state.copyWith(gender: gender, isLoading: false);
  }

  Future<void> toggleGender() async {
    final newGender = state.isMale ? 'Femenino' : 'Masculino';
    await setGender(newGender);
  }
}

/// Provider para el controlador del género
final genderNotifierProvider =
    StateNotifierProvider<GenderNotifier, GenderState>((ref) {
      final storageService = ref.watch(userStorageServiceProvider);
      return GenderNotifier(storageService);
    });

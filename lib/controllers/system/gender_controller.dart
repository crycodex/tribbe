import 'package:flutter/material.dart';

enum Gender { masculine, feminine }

class GenderController extends ChangeNotifier {
  Gender _gender = Gender.masculine;

  Gender get gender => _gender;

  void setGender(Gender gender) {
    _gender = gender;
    notifyListeners();
  }

  String get genderName {
    switch (_gender) {
      case Gender.masculine:
        return 'Masculino';
      case Gender.feminine:
        return 'Femenino';
    }
  }

  String get genderIcon {
    switch (_gender) {
      case Gender.masculine:
        return '♂';
      case Gender.feminine:
        return '♀';
    }
  }
}

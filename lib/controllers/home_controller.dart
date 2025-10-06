import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isLoading = false;

  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;

  void setCurrentIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void refresh() {
    notifyListeners();
  }
}

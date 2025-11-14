import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  bool isActive = false;

  void toggleTheme() {
    isActive = !isActive;
    notifyListeners();
  }
}

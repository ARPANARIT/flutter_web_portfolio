import 'package:flutter/cupertino.dart';

class MyAppState extends ChangeNotifier {
  // Manages the State
  bool isDark = false;
  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}

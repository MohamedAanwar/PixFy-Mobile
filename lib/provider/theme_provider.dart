import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.light();
  ThemeData get Theme => _theme;
  void toggleTheme() {
    final isdark = _theme == ThemeData.dark();
    if (isdark) {
      _theme = ThemeData.light();
    } else {
      _theme = ThemeData.dark();
    }
    notifyListeners();
  }
}

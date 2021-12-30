import 'package:flutter/material.dart';
import 'package:mor_app/models/dark_Theme_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreferences preferences = DarkThemePreferences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  get darkThemePreferences => null;

  set darkTheme(bool value) {
    _darkTheme = value;
    preferences.setDarkTheme(value);
    notifyListeners();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences {
  // ignore: non_constant_identifier_names
  static final THEME_STATUS = 'THEMESTATUS';

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

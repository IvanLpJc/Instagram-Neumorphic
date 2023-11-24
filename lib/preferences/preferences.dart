import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool _useDarkMode = false;

  static bool get useDarkMode {
    return _prefs.getBool('useDarkMode') ?? _useDarkMode;
  }

  static set useDarkMode(bool value) {
    _useDarkMode = value;
    _prefs.setBool('useDarkMode', _useDarkMode);
  }
}

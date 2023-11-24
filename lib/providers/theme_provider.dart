import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/preferences/preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = Preferences.useDarkMode;
  late ThemeMode currentThemeMode;

  ThemeProvider() {
    currentThemeMode = _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  Color baseColorLight = const Color(0xFFE0DEE0);
  Color baseColorDark = const Color(0xFF2E2E2E);

  bool get isDarkTheme => _isDarkTheme;

  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    Preferences.useDarkMode = value;

    if (isDarkTheme) {
      currentThemeMode = ThemeMode.dark;
    } else {
      currentThemeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}

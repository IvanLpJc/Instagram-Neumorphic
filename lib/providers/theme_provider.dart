import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  ThemeMode _currentThemeMode = ThemeMode.light;

  Color baseColorLight = const Color(0xFFE0DEE0);
  Color baseColorDark = const Color(0xFF2E2E2E);

  bool get isDarkTheme => _isDarkTheme;

  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }

  ThemeMode get currentThemeMode => _currentThemeMode;

  set currentThemeMode(ThemeMode value) {
    _currentThemeMode = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';


class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;

  bool get isDark => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

  }

}

class DarkMode{
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(),
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.grey.shade900,

  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(),
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.white,

  );
}


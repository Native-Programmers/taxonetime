import 'package:flutter/material.dart';

class MyThemes extends ChangeNotifier {
  late ThemeData _themedata;
  static bool state = false;
  static const primary = Colors.blue;
  static final primaryColor = Colors.blue.shade300;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor,
    colorScheme: const ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
    backgroundColor: Colors.black,
    cardColor: Colors.black,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 36.0),
      headline2: TextStyle(fontSize: 28.0),
      headline3: TextStyle(fontSize: 24.0),
      headline4: TextStyle(fontSize: 20.0),
      headline5: TextStyle(fontSize: 18.0),
      headline6: TextStyle(fontSize: 14.0),
      bodyText1: TextStyle(fontSize: 12.0),
      bodyText2: TextStyle(fontSize: 10.0),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
    backgroundColor: Colors.white,
    cardColor: Colors.white,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 36.0),
      headline2: TextStyle(fontSize: 28.0),
      headline3: TextStyle(fontSize: 24.0),
      headline4: TextStyle(fontSize: 20.0),
      headline5: TextStyle(fontSize: 18.0),
      headline6: TextStyle(fontSize: 14.0),
      bodyText1: TextStyle(fontSize: 12.0),
      bodyText2: TextStyle(fontSize: 10.0),
    ),
  );
  MyThemeModel(bool isActive) {
    if (isActive == null) {
      getThemeData;
    } else {
      if (isActive) {
        _themedata = darkTheme;
        state = true;
      } else {
        _themedata = lightTheme;
        state = false;
      }
    }
  }

  ThemeData get getThemeData => _themedata;

  void setThemeData(ThemeData data) {
    _themedata = data;
    notifyListeners();
  }
}

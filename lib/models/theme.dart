import 'package:flutter/cupertino.dart';

class Theme extends ChangeNotifier {
  late bool isDarkMode;
  Theme() {
    isDarkMode = false;
    getTheme();
  }
  Future<void> getTheme() async {
    isDarkMode = false;
  }
}

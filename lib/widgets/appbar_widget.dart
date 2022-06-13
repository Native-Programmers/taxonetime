// ignore_for_file: use_build_context_synchronously

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/themes.dart';

AppBar buildAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  const icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: const BackButton(),
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: const Icon(icon),
          onPressed: () async {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
            AuthController.authInstance.themeState.value = isDarkMode;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('theme', isDarkMode);

            ThemeSwitcher.of(context).changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );
}

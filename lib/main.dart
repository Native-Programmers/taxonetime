import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxonetime/screens/app/app.dart';

import 'controller/authController.dart';

bool? isViewed;
late bool themeState;
late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getBool('showHome') ?? false;
  themeState = prefs.getBool('theme') ?? false;

  Get.put(AuthController());
  AuthController.authInstance.themeState.value = themeState;
  await Firebase.initializeApp();

  runApp(
    
    TaxOneTime(
    isviewed: isViewed as bool,
  ));
}

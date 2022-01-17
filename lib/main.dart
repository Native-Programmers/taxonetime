import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:taxonetime/screens/auth/login.dart';
import 'package:taxonetime/screens/onBoarding/onBoard.dart';

import 'controller/authController.dart';
// import 'package:taxonetime/screens/wrapper/wrapper.dart';

int? isViewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  await Firebase.initializeApp();
  Get.put(AuthController());
  var isviewed = isViewed;
  runApp(
    GetMaterialApp(
      // turn it false before publishing
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepOrange,
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
      ),
      home: isviewed != 0
          ? const OnBoard()
          : const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
  );
  // configLoading();
}

// void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//     ..loadingStyle = EasyLoadingStyle.dark
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.yellow
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.yellow
//     ..textColor = Colors.yellow
//     ..maskColor = Colors.blue.withOpacity(0.5)
//     ..userInteractions = true
//     ..dismissOnTap = false;
//   // ..customAnimation = CustomAnimation();
// }

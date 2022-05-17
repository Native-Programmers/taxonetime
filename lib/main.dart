import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxonetime/screens/app/app.dart';
import 'package:taxonetime/screens/auth/login.dart';
import 'package:taxonetime/widgets/navbar.dart';

import 'controller/authController.dart';

Widget checkLogin() {
  if (FirebaseAuth.instance.currentUser == null) {
    return const Login();
  } else {
    return const BottomNavBar();
  }
}

int? isViewed;
late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(TaxOneTime(
    isviewed: isViewed,
  ));
}


// Scaffold(
//             backgroundColor: Colors.white,
//               body: Center(
                  // child: Lottie.asset('assets/animations/simple_loading.json')))
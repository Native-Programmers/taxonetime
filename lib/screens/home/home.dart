// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:taxonetime/colors/colors.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/models/user.dart';
import 'package:taxonetime/screens/chat/chatbody.dart';
import 'package:taxonetime/screens/scanners/cnicScanner.dart';

List<String> cnicImages = [];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pictures = [
    'assets/swiper/download1.jpg',
    'assets/swiper/download2.jpg',
    'assets/swiper/download3.png',
  ];
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FirebaseFirestore.instance
          .collection('userinfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (!value.exists) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: const Text(
                  'Scan CNIC to continue',
                  style: TextStyle(
                      color: Color(kDarkGreyColor),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                content: Scanners(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  email: FirebaseAuth.instance.currentUser!.email,
                ),
              ),
            ),
          );
        } else {
          FirebaseFirestore.instance
              .collection('userinfo')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            AuthController.authInstance.userData.value =
                Users.fromSnapshot(value);
            print(
                'User Data fetched : ${AuthController.authInstance.userData.value.toString()}');
          }).onError((error, stackTrace) {
            Get.snackbar(
              'Error',
              error.toString(),
              borderRadius: 0,
              backgroundColor: Colors.red,
              margin: const EdgeInsets.all(0),
              colorText: Colors.white,
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(_lastExitTime) >=
            const Duration(seconds: 2)) {
          //showing message to user

          Get.snackbar(
            'Info',
            'Press back button again to exit.',
            borderRadius: 0,
            backgroundColor: Colors.green,
            margin: const EdgeInsets.all(0),
            colorText: Colors.white,
          );
          _lastExitTime = DateTime.now();
          return false; // disable back press
        } else {
          return true; //  exit the app
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF41729F),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: pictures.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.asset(
                          i,
                          fit: BoxFit.fill,
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.to(const ChatPage());
            },
            label: const Text('CHAT'),
            icon: const Icon(Icons.chat),
            backgroundColor: const Color(0xFF41729F),
          ),
        ),
      ),
    );
  }
}

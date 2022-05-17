import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

List data = AuthController.authInstance.userData.value.documents;

class UserDocuments extends StatelessWidget {
  const UserDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return Scaffold(
          body: data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index) {
                    return Container();
                  })
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/images/nodocs.png')),
                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    const Text(
                      'No Documents Found!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    NeumorphicButton(
                        margin: EdgeInsets.only(top: 12),
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => WillPopScope(
                                    onWillPop: () async => false,
                                    child: AlertDialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      content: Lottie.asset(
                                          'assets/animations/squares_loading.json'),
                                    ),
                                  ));
                          Future.delayed(const Duration(seconds: 3))
                              .then((value) {
                            Get.back();
                            Get.back();
                          });
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(8)),
                          //border: NeumorphicBorder()
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                          "Go Back",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
        );
      }),
    );
  }
}

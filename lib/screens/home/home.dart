import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/screens/chat/chatbot.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                AuthController.authInstance.signOut();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(const Chatbot());
          },
          label: const Text('CHAT'),
          // icon: const FaIcon(FontAwesomeIcons.facebookMessenger),
          icon: const Icon(Icons.chat),
        ),
      ),
    );
  }
}

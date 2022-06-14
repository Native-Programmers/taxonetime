// ignore_for_file: library_private_types_in_public_api

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/models/userData.dart';
import 'package:taxonetime/screens/profile/edit_profile_page.dart';
import 'package:taxonetime/widgets/appbar_widget.dart';
import 'package:taxonetime/widgets/button_widget.dart';
import 'package:taxonetime/widgets/numbers_widget.dart';
import 'package:taxonetime/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: '',
                onClicked: () {
                  Get.to(EditProfilePage());
                },
              ),
              const SizedBox(height: 24),
              buildName(AuthController.authInstance.userData.value),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              NumbersWidget(),
              const SizedBox(height: 48),
              buildAbout(AuthController.authInstance.userData.value),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(UsersData user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );

  Widget buildAbout(UsersData user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'CNIC: ${user.cnic}',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Text(
              'Address: ${user.address}',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

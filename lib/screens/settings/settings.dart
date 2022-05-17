import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/screens/documents/user_documents.dart';
import 'package:taxonetime/screens/profile/profile_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: const Text("Settings"),
                // backgroundColor: const Color(0xFF41729F),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ProfilePage());
                        },
                        child: const ListTile(
                          title: Text(
                            "Profile",
                          ),
                          trailing: Icon(Icons.person),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.transparent,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const UserDocuments());
                        },
                        child: const ListTile(
                          title: Text("Uploaded Documents"),
                          trailing: Icon(Icons.document_scanner),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.transparent,
                      ),
                      const ListTile(
                        title: Text("Service History"),
                        trailing: Icon(Icons.design_services_sharp),
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.transparent,
                      ),
                      const ListTile(
                        title: Text("App Settings"),
                        trailing: Icon(Icons.settings),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF41729F),
                            ),
                            onPressed: () {
                              AuthController.authInstance.signOut();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.logout),
                                Text("Logout"),
                              ],
                            )),
                      ),
                      const Divider(
                        height: 20,
                        color: Colors.transparent,
                      ),
                    ],
                  )
                ],
              )),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taxonetime/controller/authController.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            backgroundColor: const Color(0xFF41729F),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.grey.withAlpha(50),
                    child: const ListTile(
                      title: Text(
                        "Profile",
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  Container(
                    color: Colors.grey.withAlpha(50),
                    child: const ListTile(
                      title: Text("Uploaded Documents"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  Container(
                    color: Colors.grey.withAlpha(50),
                    child: const ListTile(
                      title: Text("Service History"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  Container(
                    color: Colors.grey.withAlpha(50),
                    child: const ListTile(
                      title: Text("App Settings"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
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
  }
}

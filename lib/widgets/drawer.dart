import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/screens/chat/chatbody.dart';
import 'package:taxonetime/screens/documents/user_documents.dart';
import 'package:taxonetime/screens/profile/profile_page.dart';
import 'package:taxonetime/widgets/user_credit_card.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.black.withAlpha(75),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              softWrap: true,
                              text: TextSpan(
                                text: 'Hi!\n',
                                style: const TextStyle(fontSize: 24),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AuthController
                                          .authInstance.userData.value.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                          Get.to(const ChatPage());
                        },
                        child: const ListTile(
                          title: Text("Chat"),
                          trailing: Icon(Icons.message),
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
                      InkWell(
                        onTap: () {
                          Get.to(const UserCard());
                        },
                        child: const ListTile(
                          title: Text("Payment Cards"),
                          trailing: Icon(Icons.credit_card),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

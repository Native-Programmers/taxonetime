import 'package:flutter/material.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/models/user.dart';
import 'package:taxonetime/screens/auth/login.dart';
import 'package:taxonetime/widgets/navbar.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthController();
    return StreamBuilder(
        stream: authService.user,
        builder: (_, AsyncSnapshot<Users?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final Users? user = snapshot.data;
            return user != null ? const BottomNavBar() : const Login();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:taxonetime/screens/inputTimeline/cnicScanner.dart';

class AddUserInfo extends StatefulWidget {
  AddUserInfo({Key? key, required this.uid, required this.email})
      : super(key: key);
  String uid;
  String? email;

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

class _AddUserInfoState extends State<AddUserInfo> {
  @override
  Widget build(BuildContext context) {
    GlobalKey _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        child: ListView(
          shrinkWrap: true,
          children: const [Scanners()],
        ),
      ),
    );
  }
}

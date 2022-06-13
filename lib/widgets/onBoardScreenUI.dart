// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:taxonetime/models/onBoardModel.dart';
import 'package:taxonetime/screens/onBoard/constant.dart';

class onBoardPageUI extends StatelessWidget {
  onBoardPageUI({Key? key, required this.index, required this.screens})
      : super(key: key);
  int index;
  OnboardModel screens;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index % 2 != 0 ? kblack : kwhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(screens.img),
          const Divider(height: 25, color: Colors.transparent),
          Text(
            screens.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              color: index % 2 == 0 ? kblack : kwhite,
            ),
          ),
          const Divider(height: 25, color: Colors.transparent),
          Text(
            screens.desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: index % 2 == 0 ? kblack : kwhite,
            ),
          ),
        ],
      ),
    );
  }
}

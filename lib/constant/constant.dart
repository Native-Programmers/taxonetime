import 'package:flutter/material.dart';
import 'package:taxonetime/colors/colors.dart';

Color kblue = Color(0xFF4756DF);
Color kwhite = Color(0xFFFFFFFF);
Color kblack = Color(0xFF000000);
Color kbrown300 = Color(0xFF8D6E63);
Color kbrown = Color(0xFF795548);
Color kgrey = Color(0xFFC0C0C0);

final EBstyle = BoxDecoration(
  gradient: const LinearGradient(
      colors: [
        Color(kDeepDarkGreenColor),
        Color(kDarkGreenColor),
        Color(kGradientGreyColor),
      ],
      stops: [
        0.0,
        0.5,
        1.0
      ],
      tileMode: TileMode.mirror,
      end: Alignment.bottomCenter,
      begin: Alignment.topRight),
  borderRadius: BorderRadius.circular(5),
);
const divider = Divider(
  color: Colors.transparent,
  height: 10,
);
const Vdivider = VerticalDivider(
  color: Colors.transparent,
  width: 10,
);

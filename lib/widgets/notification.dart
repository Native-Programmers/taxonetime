import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(
    {required String error, required String message, required String type}) {
  Color Bcolor;
  Color color;
  if (type == 'e') {
    Bcolor = Colors.red;
    color = Colors.white;
  } else if (type == 's') {
    color = Colors.white;

    Bcolor = Colors.green;
  } else {
    color = Colors.black;

    Bcolor = Colors.white;
  }
  Get.snackbar(error, message,
      borderRadius: 0,
      margin: const EdgeInsets.all(0),
      backgroundColor: Bcolor,
      colorText: color);
}

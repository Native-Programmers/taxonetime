import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxonetime/screens/inputTimeline/confirm.dart';
import 'package:taxonetime/screens/scanners/cnicScanner.dart';
import 'package:getwidget/getwidget.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({Key? key}) : super(key: key);

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  List<Widget> widgets = [
    Scanners(),
    Scanners(),
    Confirmation(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scanners();
  }
}

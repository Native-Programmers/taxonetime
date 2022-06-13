// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:taxonetime/themes.dart';

class ServiceWidget extends StatelessWidget {
  ServiceWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);
  String title, imageUrl;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Row(
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(imageUrl)),
        )
      ],
    ));
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:taxonetime/themes.dart';

class ServiceWidget extends StatelessWidget {
  ServiceWidget({
    Key? key,
    required this.title,
    required this.desc,
    required this.imageUrl,
  }) : super(key: key);
  String title, desc, imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: MyThemes.state ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [BoxShadow()],
        ),
        child: Wrap(
          children: [
            SizedBox(
                height: 120,
                width: 180,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
              width: 180,
              padding: const EdgeInsets.symmetric(horizontal: 2.5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
              ),
              child: Text(
                title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

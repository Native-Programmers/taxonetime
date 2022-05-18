import 'package:flutter/material.dart';

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.5),
          child: Container(
            height: 200,
            width: 225,
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow()],
            ),
            child: Column(
              children: [
                Container(
                    height: 125,
                    width: 225,
                    child: Image.network(imageUrl)),
                Container(
                  height: 75,
                  width: double.infinity,
                  child: Text(title),
                ),
              ],
            ),
          ),
        ));
  }
}

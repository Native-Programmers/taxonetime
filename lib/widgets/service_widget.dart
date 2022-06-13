// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
          ),
          Text(title),
        ],
      ),
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('services')
                .where('category', isEqualTo: title.toLowerCase())
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text('No entries found.');
              }
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: Column(
                        children: [
                          Image.network(snapshot.data!.docs[index]['imageUrl']),
                          Text(snapshot.data!.docs[index]['name']),
                        ],
                      ));
                    },
                  ),
                );
              } else {
                return const Center(
                  child: SpinKitCubeGrid(color: Colors.blueGrey),
                );
              }
            })
      ],
    );
  }
}

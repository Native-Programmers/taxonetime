import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taxonetime/models/categories.dart';
import 'package:taxonetime/models/service.dart';
import 'package:taxonetime/screens/services/service_details.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key? key, required this.category}) : super(key: key);
  Categories category;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ExpansionTile(
      title: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              color: Colors.white,
            ),
            child: ClipOval(
                child: Image.network(
              category.imageUrl,
              fit: BoxFit.contain,
            )),
          ),
          const VerticalDivider(
            width: 10,
            color: Colors.transparent,
          ),
          Text(category.name),
        ],
      ),
      children: [
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('services')
                .where('categoryId'.trim(), isEqualTo: category.id)
                .get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...snapshot.data!.docs.map((e) {
                      return InkWell(
                        onTap: () {
                          Get.to(ServiceDetails(
                              services: Services.fromSnapshot(e)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: Colors.white,
                                  ),
                                  height: 35,
                                  width: 35,
                                  child: ClipOval(
                                    child: Image.network(
                                      e['imageUrl'],
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              const Divider(
                                height: 10,
                                color: Colors.transparent,
                              ),
                              Text(e['name']),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No Services in this field exist'),
                );
              } else {
                return const Center(
                  child: SpinKitCubeGrid(color: Colors.blueGrey),
                );
              }
            }),
      ],
    ));
  }
}

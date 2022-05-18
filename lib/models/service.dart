import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Services extends Equatable {
  String id, serviceName, desc, imageUrl;
  int servicePrice;
  Services({
    required this.id,
    required this.serviceName,
    required this.servicePrice,
    required this.desc,
    required this.imageUrl,
  });
  @override
  List<Object?> get props => [id, serviceName, desc, imageUrl, servicePrice];

  static Services fromSnapshot(DocumentSnapshot snapshot) {
    Services service = Services(
      id: snapshot.id,
      serviceName: snapshot['name'],
      servicePrice: snapshot['price'],
      desc: snapshot['desc'],
      imageUrl: snapshot['imageUrl'],
    );
    return service;
  }
}

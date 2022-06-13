import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  String id, name, imageUrl;

  Categories({required this.id, required this.imageUrl, required this.name});
  @override
  List<Object?> get props => [id, name, imageUrl];
  static Categories fromSnapshot(DocumentSnapshot snapshot) {
    Categories categories = Categories(
        id: snapshot.id,
        name: snapshot['name'],
        imageUrl: snapshot['imageUrl']);
    return categories;
  }
}

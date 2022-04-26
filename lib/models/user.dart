import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User extends Equatable {
  String uid, email, cnic, name, deviceId;
  DateTime dob;
  List<String> documents;

  User(
      {required this.cnic,
      required this.dob,
      required this.documents,
      required this.email,
      required this.name,
      required this.deviceId,
      required this.uid});
  @override
  List<Object?> get props => [name, cnic, email, uid, dob, documents, deviceId];

  static User fromSnapshot(DocumentSnapshot snapshot) {
    User user = User(
      cnic: snapshot['cnic'],
      dob: snapshot['dob'],
      documents: snapshot['documents'],
      email: snapshot['email'],
      name: snapshot['userName'],
      deviceId: snapshot['deviceId'],
      uid: FirebaseAuth.instance.currentUser!.uid,
    );
    return user;
  }
}

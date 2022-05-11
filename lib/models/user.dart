// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users extends Equatable {
  String uid, email, dob, name, deviceId, cnicFront, cnicBack;

  List<String> documents;

  Users(
      {required this.cnicFront,
      required this.cnicBack,
      required this.dob,
      required this.documents,
      required this.email,
      required this.name,
      required this.deviceId,
      required this.uid});
  @override
  List<Object?> get props => [name, email, uid, dob, documents, deviceId];

  static Users fromSnapshot(DocumentSnapshot snapshot) {
    Users user = Users(
      cnicFront: snapshot['cnic'].cnicFront,
      cnicBack: snapshot['cnic'].cnicBack,
      dob: snapshot['dob'],
      documents: snapshot['documents'],
      email: snapshot['email'],
      name: snapshot['userName'],
      deviceId: snapshot['deviceId'],
      uid: snapshot.id,
    );
    return user;
  }
}

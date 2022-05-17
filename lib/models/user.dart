// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Users extends Equatable {
  String uid, email, dob, name, cnic;

  List documents;

  Users(
      {required this.dob,
      required this.documents,
      required this.email,
      required this.name,
      required this.uid,
      required this.cnic});
  @override
  List<Object?> get props => [name, email, uid, dob, documents];

  static Users fromSnapshot(DocumentSnapshot snapshot) {
    Users user = Users(
      dob: snapshot['dob'],
      documents: snapshot['documents'],
      email: snapshot['email'],
      name: snapshot['username'],
      cnic: snapshot['cnic'],
      uid: snapshot.id,
    );
    return user;
  }
}

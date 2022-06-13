// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UsersData extends Equatable {
  String uid, email, dob, name, cnic, address, contact;

  List documents;

  UsersData({
    required this.dob,
    required this.documents,
    required this.email,
    required this.name,
    required this.uid,
    required this.cnic,
    required this.address,
    required this.contact,
  });
  @override
  List<Object?> get props => [name, email, uid, dob, documents];

  static UsersData fromSnapshot(DocumentSnapshot snapshot) {
    UsersData user = UsersData(
      dob: snapshot['dob'],
      documents: snapshot['documents'],
      email: snapshot['email'],
      name: snapshot['username'],
      cnic: snapshot['cnic'],
      address: snapshot['address'],
      contact: snapshot['contact'],
      uid: snapshot.id,
    );
    return user;
  }
}

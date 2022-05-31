import 'package:cloud_firestore/cloud_firestore.dart';

class UserD{
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String age;
  final String agepref;
  final String gender;
  final String genderpref;
  final String gameplay;
  final String gametime;
  final String gamertype;

  UserD({
    required this.id,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.displayName,
    required this.age,
    required this.agepref,
    required this.gender,
    required this.genderpref,
    required this.gameplay,
    required this.gametime,
    required this.gamertype,
  });

  factory UserD.fromDocument(DocumentSnapshot doc) {
    return UserD(
      displayName: doc['displayName'],
      email: doc['email'],
      id: doc['id'],
      photoUrl: doc['photoUrl'],
      username: doc['username'],
      age: doc['age'],
      agepref: doc['agepref'],
      gender: doc['gender'],
      genderpref: doc['genderpref'],
      gameplay: doc['gameplay'],
      gametime: doc['gametime'],
      gamertype: doc['gamertype'],
    );
  }
}

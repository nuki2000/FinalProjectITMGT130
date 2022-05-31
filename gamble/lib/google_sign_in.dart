import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_dating_app/user.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final DateTime timestamp = DateTime.now();
UserD? currentUser;

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext screen) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    await createUserInFireStore(screen);
    notifyListeners();
    return true;
  }

  createUserInFireStore(BuildContext screen) async {
    DocumentSnapshot doc = await usersRef.doc(user.id).get();
    if(!doc.exists) {
      final username = await Navigator.pushNamed(screen, '/new');
      final age = await Navigator.pushNamed(screen, '/new2');
      final agepref = await Navigator.pushNamed(screen, '/new3');
      final gender = await Navigator.pushNamed(screen, '/new4');
      final genderpref = await Navigator.pushNamed(screen, '/new5');
      final gameplay = await Navigator.pushNamed(screen, '/new6');
      final gametime = await Navigator.pushNamed(screen, '/new7');
      final gamertype = await Navigator.pushNamed(screen, '/new8');

      usersRef.doc(user.id).set({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "age": age,
        "agepref": agepref,
        "gender": gender,
        "genderpref": genderpref,
        "gameplay": gameplay,
        "gametime": gametime,
        "gamertype": gamertype,
        "timestamp": timestamp,
      });

      doc = await usersRef.doc(user.id).get();
    }

    currentUser = UserD.fromDocument(doc);
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
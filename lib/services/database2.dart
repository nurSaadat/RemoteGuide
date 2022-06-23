import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {

  DatabaseReference ref = FirebaseDatabase.instance.ref("users/register");

  Future updateUserData(String username, String name, String email, bool role) async {

    await ref.set({
      "username": username,
      "name": name,
      "email": email,
      "guide": role,
    });
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('roles');

  Future updateUserData(String username, String name, String role) async {
    return await userCollection.doc(uid).set({
      'username': username,
      'name': name,
      'role': role,
    });
  }

  // get collection stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
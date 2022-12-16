import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String email, String name, bool guide) async {
    return await userCollection.doc(email).set({
      'name': name,
      'guide': guide,
    });
  }

  // get collection stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
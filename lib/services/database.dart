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

  Future getUserType(String? email) async {
    return await userCollection
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            return(documentSnapshot.data());
          } else {
            return(null);
          }
        });
  }

  // get collection stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
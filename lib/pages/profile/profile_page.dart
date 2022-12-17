import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  String profileImageUrl = "";

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    getProfileImage(auth.currentUser?.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(children: [Column(
            // Avatar circle
            children: [
              profileImageUrl.isNotEmpty ? CircleAvatar(backgroundImage: NetworkImage(profileImageUrl)) : Text("Haha, no luck")
              // CircleAvatar(backgroundImage: NetworkImage(profileImageUrl))
            ],
            // change avatar link
          )],),
          Row(
            children: [
              Column(
              //
              )
            ],
          ),
        ],
      ),
    );
  }

  getProfileImage(String? email) {
    Reference firebaseStorage = FirebaseStorage.instance.ref();

    print("[INFO] Get profile image $email");
    var urlRef = firebaseStorage
        .child("profile_images")
        .child('${email?.toLowerCase()}.jpg');

    print("[INFO] Get profile image $urlRef ");

    urlRef
        .getDownloadURL()
        .then((value) {
          print("[INFOOOOOOOO] Get profile image $value ");
          setState((){
            profileImageUrl = value;
          });
        });
  }
}
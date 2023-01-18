import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  String _profileImageUrl = "";
  String _name = "";
  String _email = "";
  String _status = "";

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    getProfileInfo(auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          _profileImageUrl.isNotEmpty ? CircleAvatar(backgroundImage: NetworkImage(_profileImageUrl), radius: 50,) : Text("Haha, no luck"),
          // change profile photo link
          InkWell(
              child: const Text('Change profile photo'),
              onTap: () => launchUrlString('https://docs.flutter.io/flutter/services/UrlLauncher-class.html')
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Name"),
                    Text("Email"),
                    Text("Status"),
                ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Column(
                    children: [
                      Text(_name),
                      Text(_email),
                      Text(_status),
                  ],
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  getProfileInfo(User? user) {
    _email = (user != null ? user?.email : "")!;

    CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    userCollection.doc(_email).get().then((value) {
      _name = value.get('name');
      _status = value.get('guide').toString();
    });

    Reference firebaseStorage = FirebaseStorage.instance.ref();

    var urlRef = firebaseStorage
        .child("profile_images")
        .child('${user?.email?.toLowerCase()}.jpg');

    urlRef
        .getDownloadURL()
        .then((value) {
          print("[INFOOOOOOOO] Get profile image $value ");
          setState((){
            _profileImageUrl = value;
          });
        });
  }
}
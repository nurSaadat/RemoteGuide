import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late Future<String?> _data;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    Reference firebaseStorage = FirebaseStorage.instance.ref();

    var urlRef = firebaseStorage
        .child("profile_images")
        .child('${auth.currentUser?.email?.toLowerCase()}.jpg');

    _data = urlRef.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object?>(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(snapshot.data.toString());
              // CircleAvatar(backgroundImage: NetworkImage(snapshot.data.toString()), radius: 50,);
          //   // change profile photo link
          //   InkWell(
          //       child: const Text('Change profile photo'),
          //       onTap: () => launchUrlString('https://docs.flutter.io/flutter/services/UrlLauncher-class.html')
          //   ),
          }
          else {
            return const CircularProgressIndicator();
          }
        }
    );
    //   (
    //   children: [
    //     _profileImageUrl.isNotEmpty ? CircleAvatar(backgroundImage: NetworkImage(_profileImageUrl), radius: 50,) : Text("Haha, no luck"),
    //   // change profile photo link
    //   InkWell(
    //       child: const Text('Change profile photo'),
    //       onTap: () => launchUrlString('https://docs.flutter.io/flutter/services/UrlLauncher-class.html')
    //   ),
    // ]);
  }
}

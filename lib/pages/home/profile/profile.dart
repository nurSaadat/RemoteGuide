import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/profile/profile_info.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<Object?> _data;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    _data = userCollection.doc(auth.currentUser?.email).get();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.displayMedium!,
        textAlign: TextAlign.center,
        child:
          FutureBuilder<Object?>(
            future: _data,
            builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ProfileInfo(snapshot.data);
              }
              else {
                return const CircularProgressIndicator();
              }
            }
        )
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextStyle(
//         style: Theme.of(context).textTheme.displayMedium!,
//         textAlign: TextAlign.center,
//         child: FutureBuilder<String>(
//           future: _calculation,
//           builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//             List<Widget> children;
//             if (snapshot.hasData) {
//               children = <Widget>[
//                 const Icon(
//                   Icons.check_circle_outline,
//                   color: Colors.green,
//                   size: 60,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text('Result: ${snapshot.data}'),
//                 ),
//               ];
//             } else {
//               children = const <Widget>[
//                 SizedBox(
//                   width: 60,
//                   height: 60,
//                   child: CircularProgressIndicator(),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text('Awaiting result...'),
//                 )
//               ];
//             }
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: children,
//               ),
//             );
//           }
//         )
//     );
//   }
// }

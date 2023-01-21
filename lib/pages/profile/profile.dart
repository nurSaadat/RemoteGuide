import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

class ProfileInfo extends StatefulWidget {
  final data;
  const ProfileInfo(this.data, {super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 8.0),
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
                        Text(widget.data.get('name')),
                        Text(widget.data.get('email')),
                        Text(widget.data.get('guide') ? "Guide" : "Client"),
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

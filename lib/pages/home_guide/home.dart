import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_guide_firebase/pages/home_guide/home_client.dart';
import 'package:remote_guide_firebase/pages/profile/profile.dart';
import 'package:remote_guide_firebase/pages/home_guide/upcoming/upcoming.dart';
import 'package:remote_guide_firebase/services/auth.dart';
import 'package:remote_guide_firebase/services/database.dart';
import 'package:remote_guide_firebase/pages/home_guide/my_routes/my_routes.dart';

import 'home_guide.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class CustomUser {
  final name;
  final email;
  final guide;
  
  CustomUser(this.guide, this.email, this.name);
}

class _Home extends State<Home> {
  late Future<DocumentSnapshot<Object?>?> _data;
  late List<Widget> _widgetOptions = <Widget>[
    MyRoutes(),
    UpcomingTours(),
    Profile()
  ];

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    _data = userCollection.doc(auth.currentUser?.email).get();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().users,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Home page'),
          backgroundColor: Colors.blue[600],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              onPressed: () async{
                await _auth.signOut();
              },
              style: TextButton.styleFrom(
                  primary: Colors.white
              ),
            )
          ],
        ),
        body: FutureBuilder<DocumentSnapshot?>(
            future: _data,
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                if (data["guide"]){
                  return HomeGuide(snapshot.data);
                } else {
                  return HomeClient(snapshot.data);
                }
              }
              else {
                return const CircularProgressIndicator();
              }
            }
        )
        // Center(
        //       child: _widgetOptions.elementAt(_selectedIndex),
        //   ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.list),
        //       label: 'My routes',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.schedule),
        //       label: 'Upcoming',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.amber[800],
        //   onTap: _onItemTapped,
        // ),
    )
    );
  }
}

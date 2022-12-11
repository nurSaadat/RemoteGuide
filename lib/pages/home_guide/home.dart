import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_guide_firebase/pages/home_guide/my_routes/locating.dart';
import 'package:remote_guide_firebase/pages/home_guide/profile_page.dart';
import 'package:remote_guide_firebase/pages/home_guide/upcoming/upcoming.dart';
import 'package:remote_guide_firebase/services/auth.dart';
import 'package:remote_guide_firebase/services/database.dart';
import 'package:remote_guide_firebase/pages/home_guide/my_routes/my_routes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}
class _Home extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyRoutes(),
    UpcomingTours(),
    ProfilePage()
  ];

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
        body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'My routes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Upcoming',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
    )
    );
  }
}

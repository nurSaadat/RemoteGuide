import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/profile/profile.dart';
import 'package:remote_guide_firebase/pages/home/upcoming/upcoming.dart';
import 'my_routes/my_routes.dart';

class HomeClient extends StatefulWidget {
  final data;
  const HomeClient(this.data, {super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  late final List<Widget> _widgetOptions = <Widget>[
    const MyRoutes(),
    const UpcomingTours(),
    const Profile()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

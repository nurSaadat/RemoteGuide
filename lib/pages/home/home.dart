import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_guide_firebase/services/auth.dart';
import 'package:remote_guide_firebase/services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().users,
      initialData: null,
      child: Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Remote Guide'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('LogOut'),
            onPressed: () async{
              await _auth.signOut();
            },
          )
        ],
      ),
    )
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/my_routes/create_route.dart';
import 'package:remote_guide_firebase/pages/home/my_routes/routes_list.dart';


class MyRoutes extends StatefulWidget {
  const MyRoutes({Key? key}) : super(key: key);

  @override
  State<MyRoutes> createState() => _MyRoutes();
}

class _MyRoutes extends State<MyRoutes> {
  List<Map<String, dynamic>> data = [];

  deleteRoute(String title) {
    CollectionReference ref = FirebaseFirestore.instance.collection('routes');
    ref.doc(title).delete();
    setState(() {
      data.removeWhere((element) => element["name"] == title);
    });
  }

  getRouteList() {
    CollectionReference ref = FirebaseFirestore.instance.collection('routes');
    ref.get().then((QuerySnapshot querySnapshot) {
      print("[INFO] Getting the routes...");
      for (var doc in querySnapshot.docs) {
        final path = 'tour_cover_images/${doc.get('imagePath')}';
        final ref = FirebaseStorage.instance.ref().child(path);

        ref.getData().then((value) {
          data.add({
            "name": doc.get('name'),
            "description": doc.get('description'),
            "image": Image.memory(value!),
          });
          // update the state of the widget to see changes in the UI
          setState(() => data = data);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getRouteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RoutesList(data, deleteRoute),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add new route'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateRoute()),
          );
        },
      ),
    );
  }
}
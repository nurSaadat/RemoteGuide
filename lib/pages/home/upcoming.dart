import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'my_routes/routes_list.dart';

class UpcomingTours extends StatefulWidget {
  const UpcomingTours({Key? key}) : super(key: key);

  @override
  State<UpcomingTours> createState() => _UpcomingTours();
}

class _UpcomingTours extends State<UpcomingTours> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    getRouteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RoutesList(data, deleteRoute),
    );
  }

  getRouteList() {
    CollectionReference ref = FirebaseFirestore.instance.collection('bookings');
    DateTime now = DateTime.now();
    ref.where("endDate", isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day))
        .get().then((QuerySnapshot querySnapshot) {
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

  deleteRoute(String title) {
    CollectionReference ref = FirebaseFirestore.instance.collection('bookings');
    ref.doc(title).delete();
    setState(() {
      data.removeWhere((element) => element["name"] == title);
    });
  }
}

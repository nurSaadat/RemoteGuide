import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/bookings/bookings_list.dart';

import '../routes/routes_list.dart';

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
    getBookingsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookingsList(data, cancelRoute),
    );
  }

  getBookingsList() {
    CollectionReference ref = FirebaseFirestore.instance.collection('bookings');
    DateTime now = DateTime.now();
    ref.where("date", isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day))
        .get().then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            data.add({
              "name": doc.get('name'),
              "clientId": doc.get('clientId'),
            });
            // update the state of the widget to see changes in the UI
            setState(() => data = data);
          }
        });
  }

  cancelRoute(String title) {
    CollectionReference ref = FirebaseFirestore.instance.collection('bookings');
    ref.doc(title).delete();
    setState(() {
      data.removeWhere((element) => element["name"] == title);
    });
  }
}

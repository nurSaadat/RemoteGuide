import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/bookings/bookings_list.dart';

class UpcomingBookings extends StatefulWidget {
  const UpcomingBookings({Key? key}) : super(key: key);

  @override
  State<UpcomingBookings> createState() => _UpcomingBookings();
}

class _UpcomingBookings extends State<UpcomingBookings> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    getBookingsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isNotEmpty ? BookingsList(data: data, onCancel: cancelRoute) :
      Center(
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/empty.png', height: 80, width: 80),
                const Text("No bookings were found")
              ]
          )
      ),
    );
  }

  getBookingsList() {
    CollectionReference ref = FirebaseFirestore.instance.collection('bookings');
    DateTime now = DateTime.now();
    ref.where("date", isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day))
        .get().then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            data.add({
              "name": doc.get('tourName'),
              "clientId": doc.get('clientId'),
              "guideId": doc.get('guideId'),
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

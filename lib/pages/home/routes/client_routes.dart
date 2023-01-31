import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/bookings/create_booking.dart';
import 'package:remote_guide_firebase/pages/home/routes/routes_list.dart';


class RoutesToChooseFrom extends StatefulWidget {
  const RoutesToChooseFrom({Key? key}) : super(key: key);

  @override
  State<RoutesToChooseFrom> createState() => _RoutesToChooseFrom();
}

class _RoutesToChooseFrom extends State<RoutesToChooseFrom> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    getRouteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isNotEmpty ?
      RoutesList(
        data: data,
        operationsList: const ["Reserve"],
        onReserve: (String title) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBooking(tourId: title)));
        },
      ) :
      Center(
        child:
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/empty.png', height: 80, width: 80),
              const Text("No routes were found")
            ]
        )
      ),
    );
  }


  getRouteList() {
    CollectionReference ref = FirebaseFirestore.instance.collection('routes');
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
            "startDate": doc.get('startDate'),
            "endDate": doc.get('endDate'),
            "guideId": doc.get('guideId'),
            "image": Image.memory(value!),
          });
          // update the state of the widget to see changes in the UI
          setState(() {});
        });
      }
    });
  }
}

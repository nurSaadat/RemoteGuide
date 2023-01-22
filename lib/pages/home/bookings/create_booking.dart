import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/bookings/booking_info.dart';

class CreateBooking extends StatefulWidget {
  final String tourId;
  const CreateBooking({Key? key, required this.tourId}) : super(key: key);

  @override
  State<CreateBooking> createState() => _CreateBooking();
}

class _CreateBooking extends State<CreateBooking> {
  late Future<Object?> _data;

  @override
  void initState() {
    super.initState();
    CollectionReference ref = FirebaseFirestore.instance.collection('routes');
    _data = ref.doc(widget.tourId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New booking creation'),
        backgroundColor: Colors.blue[600],
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BookingInfo(snapshot.data);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

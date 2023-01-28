import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:remote_guide_firebase/pages/home/ongoing_tour/routing_map.dart';
import 'package:remote_guide_firebase/pages/home/ongoing_tour/test_map.dart';
import 'package:remote_guide_firebase/pages/home/ongoing_tour/video.dart';

class CurrentLocation extends StatefulWidget {
  final String title;
  final String clientId;
  final String guideId;

  const CurrentLocation({
    Key? key,
    required this.title,
    required this.clientId,
    required this.guideId,
  }) : super(key: key);

  @override
  State<CurrentLocation> createState() => _CurrentLocation();
}

class _CurrentLocation extends State<CurrentLocation> {
  late Future<Object?> _data;

  @override
  void initState() {
    super.initState();
    _data = getTourStrops(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object?>(
      future: _data,
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return TestMap();
            // RoutingMap(route: snapshot.data, title: widget.title, clientId: widget.clientId, guideId: widget.guideId,);
        }
        else {
          return const CircularProgressIndicator();
        }
      });
  }

Future getTourStrops(String title) {
  CollectionReference ref = FirebaseFirestore.instance.collection('tourStops');
  return ref.doc(title).get();
}

}

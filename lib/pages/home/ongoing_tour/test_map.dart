import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TestMap extends StatefulWidget {
  const TestMap({Key? key}) : super(key: key);

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  final Completer<GoogleMapController> _controller = Completer();
  static const kGoogleApiKey = "AIzaSyAZx3e0C2EULlN-xGVRJFBS78JI9esJs04";

  static const LatLng sourceL = LatLng(37.335, -122.03);
  static const LatLng destinationL = LatLng(37.334, -122.06);
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: sourceL,
          zoom: 14.5
      ),
      markers: {
        const Marker(
            markerId: MarkerId("source"),
            position: sourceL),
        const Marker(
            markerId: MarkerId("destination"),
            position: destinationL),
      },
    );
  }
}

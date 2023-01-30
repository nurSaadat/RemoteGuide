import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:image/image.dart' as dart_img;

class GuideView extends StatefulWidget {
  final data;
  final String client;
  const GuideView({required this.data, required this.client, Key? key}) : super(key: key);

  @override
  State<GuideView> createState() => _GuideView();
}

class _GuideView extends State<GuideView> {
  final Completer<GoogleMapController> _controller = Completer();
  static const kGoogleApiKey = "AIzaSyAZx3e0C2EULlN-xGVRJFBS78JI9esJs04";

  Set<Polyline> tourRoute = {};
  LocationData? currentLocation;
  Set<Marker> markers = {};


  Future<void> getCurrentLocation () async {
    final ref = FirebaseFirestore.instance;
      ref.collection('location')
          .doc(widget.client)
          .snapshots()
          .listen((event) => currentLocation = LocationData.fromMap({"latitude": event.data()!["lat"], "longitude": event.data()!["lng"]}));
          // .get().then((value) => currentLocation = LocationData.fromMap({"latitude": value.data()!["lat"], "longitude": value.data()!["lng"]}));

}

  void getPolyPoints(int? idx, source, destination) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        kGoogleApiKey,
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude, destination.longitude)
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );

      tourRoute.add(
          Polyline(
            polylineId: PolylineId("routeStop$idx"),
            points: polylineCoordinates,
            color: Colors.lightBlue,
            width: 6,
          )
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    for (var i = 0; i < widget.data.get("stopsList").length - 1; i++) {
      var source = widget.data.get("stopsList")[i];
      var destination = widget.data.get("stopsList")[i+1];
      getPolyPoints(i, LatLng(source["lat"], source["lng"]), LatLng(destination["lat"], destination["lng"]));
    }
    // getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> mapMarkers = [];
    for (var i=0; i<widget.data.get("stopsList").length; i++) {
      var coordinates = widget.data.get("stopsList")[i];
      mapMarkers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              position: LatLng(coordinates["lat"], coordinates["lng"]),
              infoWindow: InfoWindow(
                title: 'My Position $i',
              )
          )
      );
    }

    if (currentLocation != null) {
      mapMarkers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)
        ),
      );
    }

    return currentLocation == null ? Text("data") : GoogleMap(
      initialCameraPosition: CameraPosition(
          target:
          LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 14.5),
      polylines: tourRoute,
      markers: mapMarkers.toSet(),
      onMapCreated: (mapController) {
        _controller.complete(mapController);
      },
    );
  }
}

import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:image/image.dart' as dart_img;

class TestMap extends StatefulWidget {
  final data;
  const TestMap({required this.data, Key? key}) : super(key: key);

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  final Completer<GoogleMapController> _controller = Completer();
  static const kGoogleApiKey = "AIzaSyAZx3e0C2EULlN-xGVRJFBS78JI9esJs04";

  Set<Polyline> tourRoute = {};
  LocationData? currentLocation;
  Set<Marker> markers = {};

  BitmapDescriptor userIcon = BitmapDescriptor.defaultMarker;

  Future<void> getCurrentLocation () async {
    Location location = Location();

    location.getLocation().then(
          (location){
        currentLocation = location;
        setState(() {});
      },
    );

    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 14.5,
              target: LatLng(
                  newLoc.latitude!,
                  newLoc.longitude!
              )
            )
          )
        );
        setState(() {});
      });
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

  void setCustomMarkerIcon(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    Reference firebaseStorage = FirebaseStorage.instance.ref();

    var urlRef = firebaseStorage
        .child("profile_images")
        .child('${auth.currentUser?.email?.toLowerCase()}.jpg');

    urlRef.getData().then((value) {
      Uint8List? resizedData = value;
      dart_img.Image? img = dart_img.decodeImage(value!);
      dart_img.Image resized = dart_img.copyResize(img!, width: 80, height: 80);
      resizedData = Uint8List.fromList(dart_img.encodePng(resized));
      userIcon = BitmapDescriptor.fromBytes(resizedData);
    });
  }

  @override
  void initState() {
    setCustomMarkerIcon();
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
          icon: userIcon,
        ),
      );
    }

    return currentLocation == null
        ? const Center(child: Text("Loading", style: TextStyle(color: Colors.white, fontSize: 12),))
        : GoogleMap(
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

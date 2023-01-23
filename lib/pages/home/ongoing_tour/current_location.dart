import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({Key? key}) : super(key: key);

  @override
  State<CurrentLocation> createState() => _CurrentLocation();
}

const kGoogleApiKey = "AIzaSyAZx3e0C2EULlN-xGVRJFBS78JI9esJs04";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _CurrentLocation extends State<CurrentLocation> {
  final Mode _mode = Mode.fullscreen;
  late GoogleMapController googleMapController;
  var tourStops = [];

  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(45.4067382, 11.8773937),
    zoom: 14.4746,
  );
  
  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(45.4067382, 11.8773937),
      infoWindow: InfoWindow(
      title: 'My Position',
      )
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Tour is ongoing"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_markers),
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
              alignment: AlignmentDirectional.bottomStart,
              child: ElevatedButton(
                  onPressed: () => {print("[INFO] Video call started...")},
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
                  child: const Text("Call")
              ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: ElevatedButton(
                onPressed: () => {print("[INFO] Find")},
                child: const Text("Find buddies")
            ),
          ),
          Align(
              alignment: AlignmentDirectional.bottomEnd,
              child:
              ElevatedButton(
                onPressed: () {
                  // widget._sendTourStopsToDatabase(tourStops);
                  print("[INFO] Stopping the tour...");
                  Navigator.pop(context);
                },
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)),
                child: const Text("Stop"),
              )
          ),
        ],
      )
    );
  }

  Future<Position> geyCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("[ERROR]" + error.toString());
    });
    
    return await Geolocator.getCurrentPosition();
  }

  // Future<void> _determinePosition() async {
  //   Position position = await Geolocator.getCurrentPosition();
  //   setState(() {
  //     currentLatLng = LatLng(position.latitude, position.longitude);
  //   });
  //
  //   googleMapController.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 14.0));
  // }

}
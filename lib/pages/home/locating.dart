import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

class Locating extends StatefulWidget {
  final Function _sendTourStopsToDatabase;
  const Locating(this._sendTourStopsToDatabase, {Key? key}) : super(key: key);

  @override
  State<Locating> createState() => _Locating();
}

const kGoogleApiKey = "AIzaSyAZx3e0C2EULlN-xGVRJFBS78JI9esJs04";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _Locating extends State<Locating> {
  late LatLng currentLatLng = const LatLng(48, 2);
  Set<Marker> markerList = {};
  final Mode _mode = Mode.fullscreen;
  late GoogleMapController googleMapController;
  var tourStops = [];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose locations"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              // _controller.complete(controller);
              googleMapController = controller;
            },
            markers: markerList,
          ),
          Align(
              alignment: AlignmentDirectional.topStart,
              child:
              ElevatedButton(
                onPressed: () {
                  widget._sendTourStopsToDatabase(tourStops);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)),
                child: const Text("Finish adding stops"),
              )
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: ElevatedButton(
                onPressed: _findPlaces,
                child: const Text("Search places")
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0,16,16,0),
                child: Text("${tourStops.length} places added")
            )
          )
        ],
      )
    );
  }

  // Future<void> _determinePosition() async {
  //   Position position = await Geolocator.getCurrentPosition();
  //   setState(() {
  //     currentLatLng = LatLng(position.latitude, position.longitude);
  //   });
  //
  //   googleMapController.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 14.0));
  // }

  Future<void> _findPlaces() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: (PlacesAutocompleteResponse response) => print("[ERROR] ${response.errorMessage}"),
      mode: _mode,
      language: 'en',
      strictbounds: false,
      types: [""],
      decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white))
      ),
      components: []
    );
    displayPredictions(p!);
  }

  Future<void> displayPredictions(Prediction p) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );
    
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry?.location.lat;
    final lng = detail.result.geometry?.location.lng;

    markerList.clear();
    markerList.add(Marker(
      markerId:  const MarkerId("0"),
      position: LatLng(lat!, lng!),
      infoWindow: InfoWindow(title: detail.result.name)
    ));

    tourStops.add(detail.result.placeId);
    setState(() {
      tourStops = tourStops;
    });
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}

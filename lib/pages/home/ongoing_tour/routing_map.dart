import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:remote_guide_firebase/pages/home/ongoing_tour/guide_view.dart';
import 'package:remote_guide_firebase/pages/home/ongoing_tour/test_map.dart';
import 'package:remote_guide_firebase/pages/home/ongoing_tour/video.dart';

class RoutingMap extends StatefulWidget {
  final String title;
  final String clientId;
  final String guideId;
  final data;

  const RoutingMap({
    Key? key,
    required this.title,
    required this.clientId,
    required this.guideId,
    required this.data,
  }) : super(key: key);

  @override
  State<RoutingMap> createState() => _RoutingMap();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _RoutingMap extends State<RoutingMap> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text("Tour is ongoing"),
          ),
          body: Stack(
            children: [
              auth.currentUser?.email == widget.guideId
                  ? GuideView(data: widget.data, client: widget.clientId)
                  : TestMap(data: widget.data, client: widget.clientId),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: ElevatedButton(
                    onPressed: () {
                      String roomName = "${widget.title.splitMapJoin(" ", onMatch: (m) => "")}-${DateFormat('dd-MM-yyyy').format(DateTime.now())}-${widget.clientId.split("@")[0]}";
                      String subjectText = "Tour name: ${widget.title} \nguide ${widget.guideId} \nfor ${widget.clientId}";

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Video(
                                    roomText: roomName,
                                    subjectText: subjectText,
                                    nameText: auth.currentUser?.email ?? "User",
                                    emailText: auth.currentUser?.email ?? "fake@email.com",
                                  )
                          )
                      );},
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
                    child: const Text("Call")
                ),
              ),
              // Align(
              //   alignment: AlignmentDirectional.bottomCenter,
              //   child: ElevatedButton(
              //       onPressed: () => {print("[INFO] Find")},
              //       child: const Text("Find buddies")
              //   ),
              // ),
              Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child:
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)),
                    child: const Text("Stop"),
                  )
              ),
            ],
          )
      ),
    );
  }
}

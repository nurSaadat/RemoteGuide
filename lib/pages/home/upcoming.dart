import 'package:flutter/material.dart';

class UpcomingTours extends StatefulWidget {
  const UpcomingTours({Key? key}) : super(key: key);

  @override
  State<UpcomingTours> createState() => _UpcomingTours();
}

class _UpcomingTours extends State<UpcomingTours> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Upcoming"),
    );

  }
}

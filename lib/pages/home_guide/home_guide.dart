import 'package:flutter/material.dart';

class HomeGuide extends StatefulWidget {
  final data;
  const HomeGuide(this.data, {super.key});

  @override
  State<HomeGuide> createState() => _HomeGuideState();
}

class _HomeGuideState extends State<HomeGuide> {
  @override
  Widget build(BuildContext context) {
    return Text("Guide app");
  }
}

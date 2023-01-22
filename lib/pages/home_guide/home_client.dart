import 'package:flutter/material.dart';

class HomeClient extends StatefulWidget {
  final data;
  const HomeClient(this.data, {super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  @override
  Widget build(BuildContext context) {
    return Text("Client app");
  }
}

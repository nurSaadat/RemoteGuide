import 'dart:typed_data';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: thumbnail,
            ),
            Expanded(
              flex: 3,
              child: _Description(
                title: title,
                subtitle: subtitle,
              ),
            ),
            GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Icon(
                Icons.more_vert,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}

class RoutesList extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const RoutesList(this.data, {super.key});

  @override
  State<RoutesList> createState() => _RoutesList();
}

class _RoutesList extends State<RoutesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 150.0,
      itemCount: widget.data.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomListItem(
          thumbnail: widget.data[index]['image'],
          title: widget.data[index]['name'],
          subtitle: widget.data[index]['description'],
        );
      },
    );
  }
}

class MyRoutes extends StatefulWidget {
  const MyRoutes({Key? key}) : super(key: key);

  @override
  State<MyRoutes> createState() => _MyRoutes();
}

class _MyRoutes extends State<MyRoutes> {
  List<Map<String, dynamic>> data = [];
  getRouteList() {
    CollectionReference ref = FirebaseFirestore.instance.collection('routes');
    ref.get().then((QuerySnapshot querySnapshot) {
      print("[INFO] Getting the routes...");
      for (var doc in querySnapshot.docs) {
        final path = 'tour_cover_images/${doc.get('imagePath')}';
        final ref = FirebaseStorage.instance.ref().child(path);

        ref.getData().then((value) {
          data.add({
            "name": doc.get('name'),
            "description": doc.get('description'),
            "image": Image.memory(value!),
          });
          setState(() => data = data);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getRouteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RoutesList(data),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Add new route'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

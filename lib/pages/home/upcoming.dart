import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpcomingTours extends StatefulWidget {
  const UpcomingTours({Key? key}) : super(key: key);

  @override
  State<UpcomingTours> createState() => _UpcomingTours();
}

class _UpcomingTours extends State<UpcomingTours> {
  String name = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Center(child:
        Column(children: [
          Text(name),
          ElevatedButton(
            onPressed: () {
              CollectionReference ref = FirebaseFirestore.instance.collection('routes');
              ref.doc('my_doc').set({
                "name": "Rome",
                "date_start": "12/11/2022"
              });
            }, child: const Text("Create")),
          ElevatedButton(
              onPressed: () {
                CollectionReference ref = FirebaseFirestore.instance.collection('routes');
                ref.doc('my_doc').get().then((DocumentSnapshot snap) {
                  if (snap.exists) {
                    setState(() {
                      name = snap.get('name');
                    });
                  } else {
                    print('ERROR: no item with the given ID');
                  }
               });
              },
  child: const Text("Read")
          ),
          ElevatedButton(
              onPressed: () {
                CollectionReference ref = FirebaseFirestore.instance.collection('routes');
                ref.doc('my_doc').update({
                  'name': 'Padua',
                });
              }, child: const Text("Update")
          ),
          ElevatedButton(
              onPressed: () {
                CollectionReference ref = FirebaseFirestore.instance.collection('routes');
                ref.doc('my_doc').delete();
              }, child: const Text("Delete")
          ),
          ])
      )
    );

  }
}

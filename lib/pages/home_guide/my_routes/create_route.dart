import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:remote_guide_firebase/pages/home_guide/my_routes/locating.dart';

import '../../../shared/filled_text_button.dart';

class CreateRoute extends StatefulWidget {
  const CreateRoute({Key? key}) : super(key: key);

  @override
  State<CreateRoute> createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  final _formKey = GlobalKey<FormState>();
  DateTimeRange? dateRange;
  String name = "";
  String description = "";
  String imagePath = "";
  bool imageUploaded = true;
  bool dateSet = true;

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.end);
    }
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() => imagePath = pickedFile.path);
    }
  }

  Future uploadFile() async {
    final path = 'tour_cover_images/${basename(imagePath)}';
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(File(imagePath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New tour creation'),
        backgroundColor: Colors.blue[600],
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(12,16,12,4),
              child: Text('Tour name'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,0,12,8),
              child: TextFormField(
                onChanged: (text) {
                  setState(() => name = text);
                },
                validator: (val) => val!.isEmpty ? 'Enter the title' : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a tour name',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12,16,12,4),
              child: Text('Tour description'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,0,12,8),
              child: TextFormField(
                onChanged: (text) {
                  setState(() => description = text);
                },
                validator: (val) => val!.isEmpty ? 'Enter the description' : null,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a description',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12,16,12,4),
              child: Text('Cover image'),
            ),
            ElevatedButton(
                child: const Text('Add image'),
                onPressed: () {
                  _getFromGallery();
                  setState(() => imageUploaded = true);
                }
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,12,12,8),
              child: imagePath.isEmpty || !imageUploaded ? (!imageUploaded ? const Text("Upload an image", style: TextStyle(color: Colors.red)) : null) : Image.file(
                File(imagePath),
                fit: BoxFit.fitHeight,
                height: 400,
                width: 250,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12,16,12,4),
              child: Text('Available dates'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,0,12,8),
              child: Row(
                children: [
                  Expanded(
                    child: FilledTextButton(
                        text: getFrom(),
                        onClicked: () => pickDateRange(context)
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledTextButton(
                        text: getUntil(),
                        onClicked: () => pickDateRange(context)
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,16,12,4),
              child: !dateSet ? const Text("Set tour dates", style: TextStyle(color: Colors.red),) : null,
            ),
          ],),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (imageUploaded && imagePath.isEmpty) {
              setState(() => imageUploaded = false);
            } else {
              if (dateRange != null && dateSet) {
                final ref = FirebaseFirestore.instance;
                ref.collection('routes').doc(name).set({
                  "name": name,
                  "description": description,
                  "imagePath": basename(imagePath),
                  "startDate": dateRange?.start,
                  "endDate": dateRange?.end,
                  "guideId": "Saadat Nursultan"
                  // go back to the previous page
                });
                uploadFile();
                print("[INFO] Route is being created...");
                // go back to the previous page
                // Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Locating(_sendTourStopsToDatabase)));
              } else {
                setState(() {
                  dateSet = false;
                });
              }
            }
          }
        },
        label: const Text('Go to the map'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 24 * 3)));
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(
          DateTime.now().month - 1
      ),
      lastDate: DateTime(
          DateTime.now().year + 5
      ),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      dateSet = true;
    });
  }

  Future<void> _sendTourStopsToDatabase(var stopsList) async {
    final ref = FirebaseFirestore.instance;
    ref.collection('tourStops')
        .doc(name)
        .set({
          "name": name,
          "stopsList": stopsList,
        });
  }
}

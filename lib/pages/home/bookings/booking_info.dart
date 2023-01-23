import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/filled_text_button.dart';

class BookingInfo extends StatefulWidget {
  final tour;
  const BookingInfo(this.tour, {Key? key}) : super(key: key);

  @override
  State<BookingInfo> createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo> {
  final _formKey = GlobalKey<FormState>();
  DateTime? bookedDate;

  String getDateButtonText() {
    if (bookedDate == null) {
      return 'Choose date';
    } else {
      return DateFormat('dd/MM/yyyy').format(bookedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15.0),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(12,16,12,4),
                child: Text('Tour name'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12,16,12,4),
                child: Text(widget.tour.get('name')),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12,16,12,4),
                child: Text('Tour date'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12,0,12,8),
                child: Expanded(
                  child: FilledTextButton(
                    text: getDateButtonText(),
                    onClicked: () => pickDate(context)
                  ),
                ),
              ),
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (bookedDate != null) {
              final FirebaseAuth auth = FirebaseAuth.instance;
              final ref = FirebaseFirestore.instance;
              ref.collection('bookings').add({
                "clientId": auth.currentUser?.email,
                "guideId": widget.tour.get('guideId'),
                "date": bookedDate,
                "tourName": widget.tour.get('name'),
              });
              // go back to the previous page
              Navigator.pop(context);
            }
          }
        },
        label: const Text('Confirm booking'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      firstDate: widget.tour.get('startDate').toDate(),
      lastDate: widget.tour.get('endDate').toDate(),
      initialDate: initialDate,
    );

    if (newDate == null) return;

    setState(() {
      bookedDate = newDate;
    });
  }

}

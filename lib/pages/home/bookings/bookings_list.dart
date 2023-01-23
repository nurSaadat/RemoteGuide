import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/ongoing_tour/current_location.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'booking_list_item.dart';

class BookingsList extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final Function? onCancel;
  const BookingsList({Key? key, required this.data, this.onCancel}) : super(key:key);

  @override
  State<BookingsList> createState() => _BookingsList();
}

class _BookingsList extends State<BookingsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 150.0,
      itemCount: widget.data.length,
      itemBuilder: (BuildContext context, int index) {
        return BookingListItem(
          title: widget.data[index]['name'],
          clientName: widget.data[index]['clientId'],
          onCancel: widget.onCancel!,
        );
      },
    );
  }
}
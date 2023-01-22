import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.onCancel,
    required this.title,
    required this.clientName,
  }) : super(key: key);

  final Function onCancel;
  final String title;
  final String clientName;

  void handleClick(String value) {
    switch (value) {
      case 'Cancel':
        onCancel(title);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _Description(
                title: title,
                subtitle: clientName,
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton.icon(
                onPressed: () {
                  launchUrlString("tel://+393519262241");
                  },
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
                icon: const Icon(Icons.call),
                label: const Text("Start the call"),
              )
            ),
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Cancel'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
                }).toList();
              },
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
        return CustomListItem(
          title: widget.data[index]['name'],
          clientName: widget.data[index]['clientId'],
          onCancel: widget.onCancel!(),
        );
      },
    );
  }
}
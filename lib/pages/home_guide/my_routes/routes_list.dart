import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.onDelete,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final Function onDelete;
  final Widget thumbnail;
  final String title;
  final String subtitle;

  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        print("[INFO] Edit");
        break;
      case 'Delete':
        print("[INFO] Delete");
        onDelete(title);
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
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Edit', 'Delete'}.map((String choice) {
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

class RoutesList extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final Function onDelete;
  const RoutesList(this.data, this.onDelete, {super.key});

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
          onDelete: widget.onDelete,
          thumbnail: widget.data[index]['image'],
          title: widget.data[index]['name'],
          subtitle: widget.data[index]['description'],
        );
      },
    );
  }
}
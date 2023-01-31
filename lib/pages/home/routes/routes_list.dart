import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/routes/route_list_item.dart';

class RoutesList extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final List<String> operationsList;
  Function? onDelete;
  Function? onReserve;

  RoutesList(
      {Key? key,
        required this.data,
        required this.operationsList,
        this.onDelete,
        this.onReserve,
      })
      : super(key: key);

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
        return RouteListItem(
          thumbnail: widget.data[index]['image'],
          title: widget.data[index]['name'],
          subtitle: widget.data[index]['description'],
          operationsList: widget.operationsList,
          onDelete: widget.onDelete,
          onReserve: widget.onReserve,
          startDate: DateTime.fromMillisecondsSinceEpoch(widget.data[index]['startDate'].seconds * 1000),
          endDate: DateTime.fromMillisecondsSinceEpoch(widget.data[index]['endDate'].seconds * 1000),
          guideId: widget.data[index]['guideId'],
        );
      },
    );
  }
}
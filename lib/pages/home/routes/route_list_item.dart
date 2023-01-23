import 'package:flutter/material.dart';

class RouteListItem extends StatelessWidget {
  final Widget thumbnail;
  final String title;
  final String subtitle;
  final List<String> operationsList;
  final Function? onDelete;
  final Function? onReserve;

  const RouteListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.operationsList,
    this.onDelete,
    this.onReserve,
  }) : super(key: key);



  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        print("[INFO] Edit");
        break;
      case 'Delete':
        onDelete!(title);
        break;
      case 'Reserve':
        print("[INFO] Reserve");
        onReserve!(title);
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
                return operationsList.map((String choice) {
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
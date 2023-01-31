import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TourInfo extends StatelessWidget {
  final Widget thumbnail;
  final String title;
  final String subtitle;
  final DateTime startDate;
  final DateTime endDate;
  final String guideId;
  final List<String> operationsList;
  final Function? onDelete;
  final Function? onReserve;

  const TourInfo({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.startDate,
    required this.endDate,
    required this.guideId,
    required this.operationsList,
    this.onDelete,
    this.onReserve,
  }) : super(key: key);

  void handleClick() {
    switch (operationsList[0]) {
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
    return Scaffold(body:
        Column(children: [
          thumbnail,
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child:
              Column(children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Text(
                  "Start date",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(startDate),
                  style: const TextStyle(fontSize: 17.0),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                // Text(DateFormat('dd/MM/yyyy').format(startDate)),
                const Text(
                  "End date",
                  style: TextStyle(
                      fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(endDate),
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                // Text(DateFormat('dd/MM/yyyy').format(endDate)),
                const Text(
                  "Guide",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  guideId,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                ElevatedButton(onPressed: handleClick, child:
                  Text(operationsList[0],
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  )
                ),
              ],
              ),
            ),
          ]
        )
    );
  }
}

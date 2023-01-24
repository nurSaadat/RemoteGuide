import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/ongoing_tour/current_location.dart';

class BookingListItem extends StatelessWidget {
  final Function onCancel;
  final String title;
  final String clientId;
  final String guideId;

  const BookingListItem({
    Key? key,
    required this.onCancel,
    required this.title,
    required this.clientId,
    required this.guideId,
  }) : super(key: key);

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
              flex: 2,
              child: _Description(
                title: title,
                clientId: clientId,
                guideId: guideId,
              ),
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    // launchUrlString("tel://+393519262241");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            CurrentLocation(
                              title: title,
                              clientId: clientId,
                              guideId: guideId,
                            )
                        )
                    );
                  },
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
                  child: const Text("Start the tour"),
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
    required this.clientId,
    required this.guideId,
  }) : super(key: key);

  final String title;
  final String clientId;
  final String guideId;

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
            "Client: $clientId",
            style: const TextStyle(fontSize: 12.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            "Guide: $guideId",
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;

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
            GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Icon(
                Icons.more_vert,
                size: 24.0,
              ),
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

class Tour {
  final String name;
  final String email;

  Tour(this.name, this.email);

  Tour.fromJson(Map<String, dynamic> json)
      : name = json['title'],
        email = json['subtitle'];
}

class RoutesList extends StatelessWidget {
  const RoutesList({Key? key}) : super(key: key);

  static final List<Map<String, dynamic>> data = [
    {
      'title': 'ABC',
      'subtitle': 'abc',
      'thumbnail': Colors.blue,
    },
    {
      'title': 'DFE',
      'subtitle': 'dfe',
      'thumbnail': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 150.0,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomListItem(
          thumbnail: Container(
            decoration: BoxDecoration(color: data[index]['thumbnail']),
          ),
          title: data[index]['title'],
          subtitle: data[index]['subtitle'],
        );
      },
    );
  }
}

class MyRoutes extends StatefulWidget {
  const MyRoutes({Key? key}) : super(key: key);

  @override
  State<MyRoutes> createState() => _MyRoutes();
}

class _MyRoutes extends State<MyRoutes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RoutesList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Add new route'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

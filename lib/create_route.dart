import 'package:flutter/material.dart';

class CreateRoute extends StatefulWidget {
  const CreateRoute({Key? key}) : super(key: key);

  @override
  State<CreateRoute> createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  DateTime? date;

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return '${date?.day}/${date?.month}/${date?.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New tour creation'),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Tour name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter a tour name',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  hintText: 'Enter a description',
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {},
                          child: const Text('Add image')
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                      left: 20
                  ),
                  child: Text ('file_name.png'),
                ),
              ],
            ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () => pickDate(context),
                        child: Text(getText())
                    )
                  ],
                ),
              ),
            ),
          ],
       ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(
            DateTime.now().month - 1
        ),
        lastDate: DateTime(
            DateTime.now().year + 5
        )
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}

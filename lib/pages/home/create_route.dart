import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/filled_text_button.dart';

class CreateRoute extends StatefulWidget {
  const CreateRoute({Key? key}) : super(key: key);

  @override
  State<CreateRoute> createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  DateTimeRange? dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(12,16,12,4),
            child: Text('Tour name'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12,0,12,8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a tour name',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12,16,12,4),
            child: Text('Tour description'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12,0,12,8),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a description',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12,16,12,4),
            child: Text('Cover image'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,8),
            child: Row(
              children: [
                FilledTextButton(
                    text: 'Add image',
                    onClicked: () {}
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
          const Padding(
            padding: EdgeInsets.fromLTRB(12,16,12,4),
            child: Text('Available dates'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,8),
            child: Row(
              children: [
                Expanded(
                  child: FilledTextButton(
                      text: getFrom(),
                      onClicked: () => pickDateRange(context)
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledTextButton(
                      text: getUntil(),
                      onClicked: () => pickDateRange(context)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Go to the map'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 24 * 3)));
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(
          DateTime.now().month - 1
      ),
      lastDate: DateTime(
          DateTime.now().year + 5
      ),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange );
  }
}

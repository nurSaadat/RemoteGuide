import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class UpcomingTours extends StatefulWidget {
  const UpcomingTours({Key? key}) : super(key: key);

  @override
  State<UpcomingTours> createState() => _UpcomingTours();
}

class _UpcomingTours extends State<UpcomingTours> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(   // NEW from here ...
      appBar: AppBar(
        title: const Text('Upcoming tours'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = _saved.contains(_suggestions[index]); // NEW
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(    // NEW from here ...
              alreadySaved ? Icons.rocket_launch : Icons.rocket,
              color: alreadySaved ? Colors.indigo : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {          // NEW from here ...
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });                // to here.
            },
          );
        },
      ),
    );

  }
}

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyRoutes extends StatefulWidget {
  const MyRoutes({Key? key}) : super(key: key);

  @override
  State<MyRoutes> createState() => _MyRoutes();
}

class _MyRoutes extends State<MyRoutes> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My routes'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = _saved.contains(_suggestions[i]);
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    radius: 10,

                  ),
                  title: Text(
                    _suggestions[i].asPascalCase,
                    style: _biggerFont,
                  ),
                  subtitle: Text(
                    _suggestions[i].asPascalCase,
                    style: _biggerFont,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {},
                        child: const Text('Edit')
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Delete')
                    )
                  ],
                )
              ],
            ),
          );
          // return ListTile(
          //   title: Text(
          //     _suggestions[index].asPascalCase,
          //     style: _biggerFont,
          //   ),
          //   trailing: Icon(    // NEW from here ...
          //     alreadySaved ? Icons.rocket_launch : Icons.rocket,
          //     color: alreadySaved ? Colors.indigo : null,
          //     semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          //   ),
          //   onTap: () {          // NEW from here ...
          //     setState(() {
          //       if (alreadySaved) {
          //         _saved.remove(_suggestions[index]);
          //       } else {
          //         _saved.add(_suggestions[index]);
          //       }
          //     });                // to here.
          //   },
          // );
        },
      ),
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

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _alreadySavedPairs = <WordPair>[];

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, item) {
          if(item.isOdd) {
            return Divider();
          }

          final index = item ~/ 2;

          if(index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_randomWordPairs[index]);
        }
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _alreadySavedPairs.contains(wordPair);

    return ListTile(title: Text(wordPair.asPascalCase),
        trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null),

        onTap: () {
          setState(() {
            if(alreadySaved) {
              _alreadySavedPairs.remove(wordPair);
            }
            else {
              _alreadySavedPairs.add(wordPair);
            }
          });
        });
  }

  void _pushButton() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext buildContext) {
            final tiles = _alreadySavedPairs.map((WordPair wordPair) {
              return ListTile(
                title: Text(wordPair.asPascalCase)
              );
            });

            final List<Widget> divider = ListTile.divideTiles(
                context: context,
                tiles: tiles).toList();

            return Scaffold(
              appBar: AppBar(title: Text("Saved Words")),
              body: ListView(children: divider)
            );
          }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Mr.Tano"),
              actions: [
                IconButton(onPressed: _pushButton, icon: Icon(Icons.list))
              ]),
        body: _buildList());
  }
}
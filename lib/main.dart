import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'draw.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Draw(),
    );
    /*final wordPair = WordPair.random();
    return MaterialApp(
      title: "Lalalal",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tities"),
        ),
        body: Center(
          child: TapDetector()
        ),
      ),
    );*/
  }
}

class RandomWords extends StatefulWidget {
  @override
  State createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Center(
          child: Text(
        pair.asPascalCase,
        style: _biggerFont,
      )),
    );
  }
}

class TapDetector extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details)=>_onTapDown(details),
    );
  }

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print("tap down " + x.toString() + ", " + y.toString());
  }

}

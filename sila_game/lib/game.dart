import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState(); // Game game = new Game();
}

class _GameState extends State<Game> {
  static const String TITLE = 'Sila Game';
  static const String IMAGE_PATH = 'assets/images/';
  static const List<String> CONSONANTS = ['b', 'c'];
  static const List<String> VOWELS = ['a', 'e', 'i', 'o', 'u'];

  int _vowelNumber = 0;
  int _consonantNumber = 0; // Random().nextInt(1);

  /// The idea for later is to do it randomly and in order
  void _updateSyllable() {
    setState(() {
      if (_vowelNumber < VOWELS.length - 1) {
        _vowelNumber++;
      } else {
        _vowelNumber = 0;
        // Random will be inserted later again.
        _consonantNumber = _consonantNumber == 0 ? 1 : 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: should I move these two later on?
    String syllable =
        CONSONANTS[_consonantNumber] + '  ' + VOWELS[_vowelNumber];
    String syllableImagePath = IMAGE_PATH +
        CONSONANTS[_consonantNumber] +
        VOWELS[_vowelNumber] +
        '.jpg';

    /// Image pressing = animal name with voice + animation in image
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(TITLE))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('A sound with the sound of the word.');
                    },
                    child: SizedBox(
                      width: 100,
                      height: 90,
                      child: Center(
                        child: Text(
                          CONSONANTS[_consonantNumber].toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 80),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('A sound saying the syllable must be heard.');
                    },
                    child: SizedBox(
                      width: 100,
                      height: 90,
                      child: Center(
                        child: Text(
                          VOWELS[_vowelNumber].toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 80),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Image(
              image: AssetImage(syllableImagePath),
              height: 250,
              semanticLabel: 'TBD: tell the name of the image displayed',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nueva Silaba',
        child: Icon(Icons.loop),
        onPressed: () {
          _updateSyllable();
        },
      ),
    );
  }
}

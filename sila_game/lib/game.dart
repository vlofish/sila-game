import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState(); // Game game = new Game();
}

class _GameState extends State<Game> {
  static const String TITLE = 'Sila Game';
  static const String PLACEHOLDER_IMAGE = 'assets/images/animals/le1.jpg';

  static const List<String> VOWELS = ['A', 'E', 'I', 'O', 'U'];
  static const List<String> CONSONANTS = [
    'B',
    'C',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'Ñ',
    'P',
    'R',
    'S',
    'T',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  static const List<String> IMAGES = [
    'assets/images/animals/ca.png',
    'assets/images/animals/ce.jpg',
    'assets/images/animals/ga.jpg',
    'assets/images/animals/le1.jpg',
    'assets/images/animals/le2.png',
    'assets/images/animals/ov.png',
    'assets/images/animals/pa.png',
    'assets/images/animals/po.png',
    'assets/images/animals/ti.png',
    'assets/images/animals/va.png',
    'assets/images/animals/ze.jpg',
  ];

  int _vowelNumber = 0;
  int _consonantNumber = Random().nextInt(20);

  /// The idea for later is to do it randomly or in order
  void _updateSila() {
    setState(() {
      if (_vowelNumber < VOWELS.length - 1) {
        _vowelNumber++;
      } else {
        _vowelNumber = 0;
        _consonantNumber = Random().nextInt(20);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String syllable =
        CONSONANTS[_consonantNumber] + '  ' + VOWELS[_vowelNumber];

    /// Image pressing = animal name with voice + animation in image
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(TITLE))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('A sound saying the syllable must be heard.');
                },
                child: SizedBox(
                  width: 300,
                  height: 90,
                  child: Center(
                    child: Text(
                      syllable,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 80),
                    ),
                  ),
                ),
              ),
            ),
            Image(image: AssetImage(IMAGES[_vowelNumber])),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Enviar',
        child: Icon(Icons.loop),
        onPressed: () {
          _updateSila();
        },
      ),
    );
  }
}

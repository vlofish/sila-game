import 'dart:math';

import 'package:flutter/material.dart';

class SilaMainGame extends StatefulWidget {
  const SilaMainGame({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SilaMainGame> {
  int _counter = 0;
  int _randomConsonant = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      if (_counter < 4) {
        _counter++;
      } else {
        _counter = 0;
        _randomConsonant = Random().nextInt(19);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var vowelsArray = ['A', 'E', 'I', 'O', 'U'];
    var consonantsArray = [
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
      'P',
      // 'Q',
      'R',
      'S',
      'T',
      'V',
      'W',
      'X',
      'Z'
    ];
    var imagesArray = [
      'images/ashoka.png',
      'images/bad-batch.png',
      'images/trooper.png',
      'images/vader.png',
      'images/yoda.webp',
    ];

    var syllable = consonantsArray[_randomConsonant] + vowelsArray[_counter];

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: Text('Sila'),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Silaba:',
            ),
            Text(
              '$syllable',
              style: Theme.of(context).textTheme.headline4,
            ),
            Image(
              image: AssetImage(imagesArray[_counter]),
              color: Colors.greenAccent,
              colorBlendMode: BlendMode.colorBurn,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

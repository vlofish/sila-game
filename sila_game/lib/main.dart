import 'package:flutter/material.dart';
import 'package:sila_game/game.dart';

void main() => runApp(SilaGame());

class SilaGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sila Game',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Game(),
    );
  }
}

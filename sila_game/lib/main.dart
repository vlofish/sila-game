import 'package:flutter/material.dart';

void main() => runApp(SilaWars());

class SilaWars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sila Game',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(title: 'Sila Game'),
    );
  }
}

class Home extends StatelessWidget {
  final String title;

  Home({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sila_game/src/sila_main_game.dart';

class SilaRouteBuilder {
  final String route;
  final WidgetBuilder builder;

  SilaRouteBuilder({
    required this.route,
    required this.builder,
  });
}

final silaRoutes = [
  SilaRouteBuilder(
    route: 'sila_main_game',
    builder: (context) => const SilaMainGame(),
  )
];

class SilaGameType extends StatelessWidget {
  const SilaGameType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sila Game',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      // TODO: Upgrade to navigation 2
      routes: Map.fromEntries(
          silaRoutes.map((sila) => MapEntry(sila.route, sila.builder))),
      home: SilaGameType2(),
    );
  }
}

class SilaGameType2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipo de Sila'),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        children: [
          Container(
            child: ElevatedButton(
              child: Text('Animales'),
              onPressed: () {
                Navigator.pushNamed(context, 'sila_main_game');
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('Objetos'),
              onPressed: () {
                Navigator.pushNamed(context, '/sila_main_game');
              },
            ),
          ),
        ],
      ),
    );
  }
}

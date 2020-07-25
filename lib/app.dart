import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/gameplay_page.dart';
import 'Team.dart';

class GamePlayMain extends StatefulWidget {
  final List<Team> llEquips;
  GamePlayMain(this.llEquips);
  // This widget is the root of the application.
  @override
  _GamePlayMain createState() => _GamePlayMain();
}

class _GamePlayMain extends State<GamePlayMain> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(home: GamePlay(widget.llEquips));
  }
}

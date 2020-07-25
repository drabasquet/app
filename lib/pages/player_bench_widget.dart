import 'package:dra/Jugador.dart';
import 'package:flutter/material.dart';
import 'player_widget.dart';

class PlayerBenchWidget extends StatefulWidget {
  final Jugador player;
  PlayerBenchWidget(this.player);
  @override
  _PlayerBenchWidgetState createState() => _PlayerBenchWidgetState();
}

class _PlayerBenchWidgetState extends State<PlayerBenchWidget> {
  int playerNumber = 0;
  int playerPts = 0;
  int playerAst = 0;
  int playerRbs = 0;
  String playerTeam = 'home';
  String relPosition = 'TL';
  Offset relCoordinates = Offset(0.0, 0.0);
  bool showStats = true;
  var iconsDict = {
    0: Icons.filter,
    1: Icons.filter_1,
    2: Icons.filter_2,
    3: Icons.filter_3,
    4: Icons.filter_4,
    5: Icons.filter_5,
    6: Icons.filter_6,
    7: Icons.filter_7,
    8: Icons.filter_8,
    9: Icons.filter_9,
  };
  var teamColor = {'home': Colors.red[900], 'visitor': Colors.blue[900]};
  @override
  void initState() {
    super.initState();
    playerNumber = widget.player.playerNumber;
    playerPts = widget.player.playerPoints;
    playerAst = widget.player.playerAssists;
    playerRbs = widget.player.playerRebounds;
    playerTeam = widget.player.team;
  }

  @override
  Widget build(BuildContext context) {
    if (relPosition == 'TL') {
      return Positioned(
        top: relCoordinates.dy,
        left: relCoordinates.dx,
        child: _createDragTarget(),
      );
    }
    if (relPosition == 'BL') {
      return Positioned(
        bottom: relCoordinates.dy,
        left: relCoordinates.dx,
        child: _createDragTarget(),
      );
    }
    if (relPosition == 'TR') {
      return Positioned(
        top: relCoordinates.dy,
        right: relCoordinates.dx,
        child: _createDragTarget(),
      );
    }
    if (relPosition == 'BR') {
      return Positioned(
        bottom: relCoordinates.dy,
        right: relCoordinates.dx,
        child: _createDragTarget(),
      );
    }
  }

  Widget _createDragTarget() {
    return DragTarget<List>(
        onAccept: (receivedAction) {
          //[1,'+1',1]
          var id = receivedAction[0];
          /* var meaning = receivedAction[1];*/
          var value = receivedAction[2];
          if (id >= 1 && id <= 6) {
            setState(() {
              playerPts += value;
            });
            _showSnackBar(context, id, playerNumber);
          }
        },
        onWillAccept: (receivedAction) => true,
        builder: (context, acceptedActions, rejectedActions) => Container(
              /* decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.green[900], width: 5)),*/
              child: Container(
                  child: Column(children: <Widget>[
                Icon(
                  iconsDict[playerNumber],
                  size: 36,
                  color: teamColor[playerTeam],
                ),
                Visibility(
                    visible: showStats,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Pts: $playerPts',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'Ast: $playerAst',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'Rbs: $playerRbs',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    )),
              ])),
            ));
  }

  void _showSnackBar(BuildContext context, int id, int playerNumber) {
    final Map actionsDecode = {
      1: '1 Point',
      2: '2 Points',
      3: '3 Points',
    };
    final snackBar = SnackBar(
      content: Text('${actionsDecode[id]} added to Player $playerNumber'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';
import '../Jugador.dart';

/*class Player {
  int playerNumber;
  int playerPoints;
  int playerAssists;
  int playerRebounds;
  String team;
  int playerPosition;

  Player(this.playerNumber, this.playerPoints, this.playerAssists,
      this.playerRebounds, this.team, this.playerPosition);
}*/

class PlayerWidget extends StatelessWidget {
  final Jugador player;
  final bool showStats;
  final Function update;
  final String teams;
  PlayerWidget(this.player, this.showStats, this.update, this.teams);

  @override
  Widget build(BuildContext context) {
    int playerNumber = player.playerNumber;
    int playerPts = player.playerPoints;
    int playerAst = player.playerAssists;
    int playerRbs = player.playerRebounds;
    String playerTeam = player.matchPlace;//player.team;
    int playerPos = player.playerPosition;
    Map iconsDict = {
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
    Map teamColor = {'home': Colors.red[900], 'visitor': Colors.blue[900]};
    Map playerPositions = {
      1: Offset(220.0, 110.0),
      2: Offset(145.0, 10.0),
      3: Offset(145.0, 10.0),
      4: Offset(60.0, 40.0),
      5: Offset(60.0, 40.0),
      6: Offset(0.0, 0.0),
    };

    void _showSnackBar(BuildContext context, int id, int playerNumber) {
      final Map actionsDecode = {
        0: 'Nothing',
        1: '1 Point',
        2: '2 Points',
        3: '3 Points',
        4: '1 Assist',
        5: '1 Rebound',
        6: '1 Foul',
      };
      if (id != 0) {
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

    Widget _createDragTarget() {
      return DragTarget<List>(
          onAccept: (receivedAction) {
            print('received');
            print('---> data: $receivedAction');
            var id = receivedAction[0];
            /* var meaning = receivedAction[1];*/
            var value = receivedAction[2];
            Jugador playerDragged = receivedAction[3];
            update(player, playerDragged, id, value);
            _showSnackBar(context, id, playerNumber);
          },
          onWillAccept: (receivedAction) => true,
          builder: (context, acceptedActions, rejectedActions) => Container(
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

    if (playerTeam == 'home') {
      if (playerPos == 1 || playerPos == 2 || playerPos == 4) {
        return Positioned(
          top: playerPositions[playerPos].dy,
          left: playerPositions[playerPos].dx,
          child: Draggable(
            data: [0, '', 0, player],
            feedback: _createDragTarget(),
            child: _createDragTarget(),
          ),
        );
      }
      if (playerPos == 3 || playerPos == 5) {
        return Positioned(
          bottom: playerPositions[playerPos].dy,
          left: playerPositions[playerPos].dx,
          child: Draggable(
            data: [0, '', 0, player],
            feedback: _createDragTarget(),
            child: _createDragTarget(),
          ),
        );
      }
    }
    if (playerTeam == 'visitor') {
      if (playerPos == 1 || playerPos == 2 || playerPos == 4) {
        return Positioned(
          top: playerPositions[playerPos].dy,
          right: playerPositions[playerPos].dx,
          child: Draggable(
            data: [0, '', 0, player],
            feedback: _createDragTarget(),
            child: _createDragTarget(),
          ),
        );
      }
      if (playerPos == 3 || playerPos == 5) {
        return Positioned(
          bottom: playerPositions[playerPos].dy,
          right: playerPositions[playerPos].dx,
          child: Draggable(
            data: [0, '', 0, player],
            feedback: _createDragTarget(),
            child: _createDragTarget(),
          ),
        );
      }
    }
    // Testing:
    if (playerPos == 6) {
      return Draggable(
        data: [0, '', 0, player],
        feedback: _createDragTarget(),
        child: _createDragTarget(),
      );
    }
  }
}

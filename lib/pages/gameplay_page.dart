import 'package:flutter/material.dart';
import 'package:dra/Jugador.dart';
import 'game_action_draggable.dart';
import 'player_widget.dart';
import 'get_data_functions.dart';
import '../main_ric.dart';
import '../Team.dart';
import '../Jugador.dart';

class GamePlay extends StatefulWidget {
  final List<Team> llEquips;
  GamePlay(this.llEquips);
  @override
  _GamePlayState createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  Map teamDic={};
  Map teamDic1 = {};
  Map teams = {};
  void initState(){
    super.initState();
    teamDic = _initDictionary(widget.llEquips[0].playerlist);
    teamDic1 = _initDictionary(widget.llEquips[1].playerlist);
    print('list of teamssss: ${widget.llEquips[0].playerlist}');
    print('list of teamssss: ${widget.llEquips[1].playerlist}');
    teams = {
      'home': teamDic,
      'visitor': teamDic1,
    };
  }
      //'visitor': {
      //  1: Jugador('agus',1, 0, 0, 0, 'visitor', 1),
      //  2: Jugador('agus',2, 0, 0, 0, 'visitor', 2),
      //  3: Jugador('agus',3, 0, 0, 0, 'visitor', 3),
      //  4: Jugador('agus',4, 0, 0, 0, 'visitor', 4),
      //  5: Jugador('agus',5, 0, 0, 0, 'visitor', 5),
      //  6: Jugador('agus',6, 0, 0, 0, 'visitor', 6),
      //  7: Jugador('agus',7, 0, 0, 0, 'visitor', 6),
      //  8: Jugador('agus',8, 0, 0, 0, 'visitor', 6),
      //  9: Jugador('agus',9, 0, 0, 0, 'visitor', 6),
      //},

  Map _initDictionary(llplayers) {
    Map teamDic = {};
    llplayers.forEach(
            (player) => teamDic[player.playerNumber] = player
    );
    print("update teams");
    return teamDic;
  }


  void _updatePage(player, playerDragged, actionId, actionValue) {
    setState(() {
      if (actionId >= 1 && actionId <= 6) {
        teams[player.team][player.playerNumber].playerPoints += actionValue;
      } else if (actionId == 0 && player.team == playerDragged.team) {
        var playerPos = teams[player.team][player.playerNumber].playerPosition;
        var playerDraggedPos = teams[playerDragged.team]
                [playerDragged.playerNumber]
            .playerPosition;
        teams[player.team][player.playerNumber].playerPosition =
            playerDraggedPos;
        teams[playerDragged.team][playerDragged.playerNumber].playerPosition =
            playerPos;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Game executed');
    print(widget.llEquips[0].name);
    return Scaffold(
        body: SafeArea(
            child: Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        OptionsBar(teams, _updatePage, widget.llEquips),
        Container(
            width: MediaQuery.of(context).size.width - 55.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ImageBanner(
                  assetPath: "assets/Images/basketball_court.jpg",
                  teams: teams,
                  update: _updatePage,
                ),
                PlayersContainer(teams: teams, update: _updatePage),
              ],
            )),
        // DragBox(Offset(200.0, 0.0), 'Box One', Colors.blueAccent),
      ],
    )));
  }
}

class OptionsBar extends StatelessWidget {
  final Map teams;
  final Function update;
  final List<Team> llEquips;
  OptionsBar(this.teams, this.update, this.llEquips);
  @override
  Widget build(BuildContext context) {
    print('OptionsBar executed');
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.blue[900], width: 4)),
      width: 55.0,
      // height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {},
              splashColor: Colors.purple,
              iconSize: 30.0,
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(Icons.assessment),
              tooltip: 'Stats',
              onPressed: () {
                print('Stats');
                print(
                    'home: ${totalPoints(teams, 'home')} - visitor: ${totalPoints(teams, 'visitor')}');
              },
              splashColor: Colors.purple,
              iconSize: 30.0,
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(Icons.save),
              tooltip: 'Save',
              onPressed: () {},
              splashColor: Colors.purple,
              iconSize: 30.0,
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: 'Exit game',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(llEquips),
                  ),
                );
              },
              splashColor: Colors.purple,
              iconSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageBanner extends StatefulWidget {
  final String assetPath;
  final Map teams;
  final Function update;
  ImageBanner({this.assetPath, this.teams, this.update});

  @override
  _ImageBannerState createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  double dxPivot = 60.0;
  double dyPivot = 40.0;
  double dxAler = 145.0;
  double dyAler = 10.0;
  double dxBase = 220.0;
  double dyBase = 110.0;
  @override
  Widget build(BuildContext context) {
    print('ImageBanner executed');
    print(widget.teams);
    return Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.80,
        ),
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(
              widget.assetPath,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            for (var val in widget.teams.values)
              for (var player in val.values)
                if (player.playerPosition <= 5)
                  PlayerWidget(
                    player,
                    true,
                    widget.update,
                  ),
            /* // Home Players
            PlayerWidget(
              widget.teams['home'][1],
              true,
            ),*/
            /* PlayerWidget2(
                Player(
                    5, widget.teams['home'][1].playerPoints, 0, 0, 'home', 5),
                true,
                widget.update), */
            GameAction(1, Offset(245.0, 260.0)),
            GameAction(2, Offset(295.0, 260.0)),
            GameAction(3, Offset(345.0, 260.0)),
            // PlayerWidget(Player(9, 0, 0, 0, 'home', 6), true, widget.update),
          ],
        ));
  }
}

class PlayersContainer extends StatefulWidget {
  final Map teams;
  final Function update;
  PlayersContainer({this.teams, this.update});
  @override
  _PlayersContainerState createState() => _PlayersContainerState();
}

class _PlayersContainerState extends State<PlayersContainer> {
  // benchPlayers<Player> players = [Player(6, 0, 0, 0, 'home'),Player(7, 0, 0, 0, 'home'),Player(8, 0, 0, 0, 'home')];
  List<int> benchPlayers = [6, 7, 8, 9];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: Colors.green[900], width: 3)),
        child: Row(
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 55) / 2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple[900], width: 3)),
              child:ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                for (var player in widget.teams['home'].values)
                  if (player.playerPosition == 6)
                    Row(
                      children: <Widget>[
                        SizedBox(width: 5.0),
                        Center(
                            child: PlayerWidget(
                          player,
                          false,
                          widget.update,
                        )),
                      ],
                    ),
              ]), 
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 55) / 2 - 6,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple[900], width: 3)),
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                for (var player in widget.teams['visitor'].values)
                  if (player.playerPosition == 6)
                    Row(
                      children: <Widget>[
                        SizedBox(width: 5.0),
                        Center(
                            child: PlayerWidget(
                          player,
                          false,
                          widget.update,
                        )),
                        
                      ],
                    )
                /* PlayerWidget(
                    Player(9, 0, 0, 0, 'home', 6), false, widget.update),
                SizedBox(width: 5.0),
                Draggable(
                  key: ValueKey(1),
                  data: [0, '', 0, true],
                  child: Container(
                    child: Center(child: Text('1')),
                    color: Colors.white,
                  ),
                  feedback: Container(
                    child: Center(child: Text('1')),
                    color: Colors.grey,
                    width: 70.0,
                    height: 50.0,
                  ),
                  childWhenDragging: Container(
                    child: Center(child: Text('1')),
                    color: Colors.red,
                  ),
                ), */
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

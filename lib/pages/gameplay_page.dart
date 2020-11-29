import 'package:dra/Equipo.dart';
import 'package:flutter/material.dart';
import 'package:dra/Jugador.dart';
import 'game_action_draggable.dart';
import 'player_widget.dart';
import 'get_data_functions.dart';
import '../main_ric.dart';
import '../Team.dart';
import '../Jugador.dart';
import '../NavigationHandlerTest.dart';

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
  bool teamSelected = false;
  bool homeTeamSelected = false;
  bool awayTeamSelected = false;
  var commandScreen = 'selectTeam';
  void initState(){
    super.initState();
    //add here a dropdown to select home and visitor team!!
    teamDic = _initDictionary(widget.llEquips[0].playerlist);
    teamDic1 = _initDictionary(widget.llEquips[1].playerlist);
    print('list of teamssss: ${widget.llEquips[0].playerlist}');
    print('list of teamssss: ${widget.llEquips[1].playerlist}');
    teams = {
      'home': teamDic,
      'visitor': teamDic1,
    };
  }

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
      if (actionId >= 1 && actionId <= 3) {
        teams[player.matchPlace][player.playerNumber].playerPoints += actionValue;
      }
      else if(actionId==4){
        teams[player.matchPlace][player.playerNumber].playerAssists += 1;
      }
      else if(actionId==5){
        teams[player.matchPlace][player.playerNumber].playerRebounds += 1;
      }
      else if (actionId == 0 && player.matchPlace == playerDragged.matchPlace) {
        var playerPos = teams[player.matchPlace][player.playerNumber].playerPosition;
        var playerDraggedPos = teams[playerDragged.matchPlace]
                [playerDragged.playerNumber]
            .playerPosition;
        teams[player.matchPlace][player.playerNumber].playerPosition =
            playerDraggedPos;
        teams[playerDragged.matchPlace][playerDragged.playerNumber].playerPosition =
            playerPos;
      }
    });
  }

  static String dropDownValueHome, dropDownValueVisitor;

  static NavigationHandlerTest nh;

  List<String> getTeams(){
    List<String> teams = <String>[];
    print('widget llequip length: ' + widget.llEquips.length.toString());
    for(int i = 0; i<widget.llEquips.length; i++){
      print('widget name: ' + widget.llEquips[i].name);
      teams.add(widget.llEquips[i].name);
    }
    return teams;
  }

  List<Jugador> getTeamPlayerList (String teamName, List<Team> _teamList ){
    print('team nameeee: ' + teamName);
    print(_teamList);
    var _localTeamList = <Team>[];

    _localTeamList = _teamList.where((team)=>team.name==teamName).toList();
    widget.llEquips[0].playerlist = _localTeamList[0].playerlist;
    return _localTeamList[0].playerlist;
  }

  Widget dropDownListHome() {
    return DropdownButton<String> (
      //value: dropDownValue,
      icon: Icon(Icons.arrow_drop_down),
      hint: Text('Please choose the home team'),
      value: dropDownValueHome,
      onChanged: (newValue) {
        setState(() {
          dropDownValueHome = newValue;
          homeTeamSelected = true;
          teamDic = _initDictionary(getTeamPlayerList(dropDownValueHome, widget.llEquips));
        });
      },
      items: getTeams().map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
    );
  }
  Widget dropDownListVisitor() {
    return DropdownButton<String> (
      //value: dropDownValue,
      icon: Icon(Icons.arrow_drop_down),
      hint: Text('Please choose the away team'),
      value: dropDownValueVisitor,
      onChanged: (newValue) {
        setState(() {
          dropDownValueVisitor = newValue;
          awayTeamSelected = true;
          teamDic1 = _initDictionary(getTeamPlayerList(dropDownValueVisitor, widget.llEquips));
        });
      },
      items: getTeams().map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Game executed');
    print(widget.llEquips[0].name);

    //if(homeTeamSelected && awayTeamSelected){
    //  teamSelected = true;
    //}

    //if(!teamSelected) {
    //  commandScreen = 'selectTeam';
    //}
    //else {
    //  commandScreen = 'startMatch';
    //}

    commandScreen = 'startMatch';

    switch(commandScreen){
      case 'selectTeam':
        return Scaffold(
          body: SingleChildScrollView(
            child:
              Column(
                children:[
                  Column(
                    children: <Widget>[
                      Container(
                        child: dropDownListHome(),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: dropDownListVisitor(),
                      ),
                    ],
                  )
                ]
              ),
          ),
        );
        break;
      case 'startMatch':
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
        break;
    }

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
                    builder: (context) => NavigationHandlerTest(llEquips), //Home(llEquips),
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
    var teamList = widget.teams.keys.toList();
    print(teamList);
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
                if (player.playerPosition <= 5 && widget.teams.containsKey('home'))
                  PlayerWidget(
                    player,
                    true,
                    widget.update,
                    teamList[0],
                  )
                else if(player.playerPosition <= 5 && widget.teams.containsKey('visitor'))
                  PlayerWidget(player, true, widget.update, teamList[1]),

            GameAction(1, Offset(245.0, 260.0)),
            GameAction(2, Offset(295.0, 260.0)),
            GameAction(3, Offset(345.0, 260.0)),
            GameAction(4, Offset(245.0, 210.0)),
            GameAction(5, Offset(295.0, 210.0)),
            GameAction(6, Offset(345.0, 210.0)),
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
    var teamList = widget.teams.keys.toList();

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
                          teamList[0],
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
                          teamList[1],
                        )),
                      ],
                    )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

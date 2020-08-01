import 'dart:math';
import 'dart:ui';

import 'package:dra/Team.dart';
import 'package:flutter/material.dart';
import 'Player.dart';
import 'Equipo.dart';

class NavigationHandlerTest extends StatefulWidget {
  NavigationHandlerTest({Key key, this.teamList}) : super(key: key);

  List teamList = <Team>[];


  @override
  _NavigationHandlerTest createState() => _NavigationHandlerTest();
}

class _NavigationHandlerTest extends State<NavigationHandlerTest> {

  List<String> updateTeamList() {
    List<String> updateTeams = <String>[];
    if (widget.teamList.length>0){
      for(int i = 0; i<widget.teamList.length; i++) {
        print(widget.teamList[i].name);
        updateTeams.add(widget.teamList[i].name);
      }
        return updateTeams;
    }else{
      List<String> noTeam = ['No teams created'];
      return noTeam;
    }
  }

  static List<Player> players = [
    Player(name: 'Lebron', position: 'base', points: 10, assists: 0, fouls: 0),
    Player(name: 'Curry', position: 'base', points: 150, assists: 0, fouls: 0),
    Player(name: 'Gasol', position: 'pivot', points: 20, assists: 0, fouls: 0)
  ];

  static String dropDownValue;

  String getMaxPoints() {
    int playersCount = widget.teamList[0].playerlist.length;
    print('player list number: ' + playersCount.toString());
    String mvp = '';
    int mvpPoints = 0;
    for (int i = 0; i<playersCount;i++){
        if(widget.teamList[0].playerlist[i].playerPoints>mvpPoints){
          mvpPoints = widget.teamList[0].playerlist[i].playerPoints;
          mvp = widget.teamList[0].playerlist[i].playerName;
        }else {
          mvp = mvp;
        }
    }
    return mvp;
  }


  Widget playerPoints() { //player with most points
    return SizedBox(
      height: 250.0,
      width: 200.0,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.green,
        child: Text('Player with most points: ' + getMaxPoints()),
      ),
    );
  }

  Widget playerAssists() {
    return SizedBox(
      height: 250.0,
      width: 200.0,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.red,
        child: Text('Player with most assists')
      ),
    );
  }

  Widget playerRebounds() {
    return SizedBox(
      height: 250.0,
      width: 200.0,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.blueAccent,
        child: Text('Player with most rebounds'),
      ),
    );
  }

  Widget teamStats(){
    return SizedBox(
      height: 250.0,
      width: 200.0,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: Text('List of players in the team'),
      ),
    );
  }

  Widget dropDownList() {
    return DropdownButton<String> (
      //value: dropDownValue,
      icon: Icon(Icons.arrow_drop_down),
      hint: Text('Please choose a team'),
      value: dropDownValue,
      onChanged: (newValue) {
        setState(() {
          dropDownValue = newValue;
        });
      },
      items: updateTeamList().map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
      child:
        Column(
          children: [
            Column(
              children: <Widget>[
                Container(
                  child: dropDownList(),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  child: playerPoints(),
                ),
                Container(
                  child: playerAssists(),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  child: playerRebounds(),
                ),
                Container(
                  child: teamStats(),
                )
              ],
            ),
          ]
        ),
      )
    );
  }
}




import 'dart:math';
import 'dart:ui';

import 'package:dra/Team.dart';
import 'package:flutter/material.dart';
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

  static String dropDownValue;

  String getMaxPoints() {
    int playersCount = widget.teamList[0].playerlist.length;
    String mvp = '';
    int mvpPoints = 0;
    for (var team in widget.teamList){
      print('team name: ' + team.name.toString());
      print('player list number: ' + team.playerlist.length.toString());
      for (int i = 0; i<team.playerlist.length;i++){
        if(dropDownValue!=null && team.name.toString().contains(dropDownValue)){
          //print('dat is die team ' + team.name.toString() + ' dropdownvalue: ' + dropDownValue.toString());

          if(team.playerlist[i].playerPoints>mvpPoints){
            print('player with most points: ' + team.playerlist[i].playerName.toString() + ' from team: ' + team.name.toString());
            print('enter');
            mvpPoints = team.playerlist[i].playerPoints;
            print('mvp points: ' + mvpPoints.toString());
            mvp = team.playerlist[i].playerName;
          }else {
            mvp = mvp;
          }
        }
        else {
          print('false');
        }
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




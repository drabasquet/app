import 'package:dra/CrearEquipo2.dart';
import 'package:dra/Jugador.dart';
import 'package:dra/NavigationHandlerTest.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'NavigationHandler.dart';
import 'Team.dart';
import 'Equipo.dart';
import 'app.dart';
import 'db/database_helper.dart';
import 'package:dra/pages/gameplay_page.dart';

class DropdownSelectTeam extends StatefulWidget {
  final List<Team> llEquips;
  DropdownSelectTeam(this.llEquips);
  @override
  _DropdownSelectTeamState createState() => _DropdownSelectTeamState();
}

class _DropdownSelectTeamState extends State<DropdownSelectTeam> {

  bool teamSelected = false;
  bool homeTeamSelected = false;
  bool awayTeamSelected = false;
  List<Team> teamList = <Team>[];

  static String dropDownValueHome, dropDownValueVisitor;
  List testin = ['m', 'n', 'o','p'];

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

  void getTeamPlayerList (String teamName, List<Team> _teamList ){
    print('team nameeee: ' + teamName);
    print(_teamList);
    var _localTeamList = <Team>[];
    _localTeamList = _teamList.where((team)=>team.name==teamName).toList();
    this.teamList.add(_localTeamList[0]);
    //return _localTeamList;
    //widget.llEquips[0].playerlist = _localTeamList[0].playerlist;
    //return _localTeamList[0].playerlist;
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
          getTeamPlayerList(dropDownValueHome, widget.llEquips);
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
          getTeamPlayerList(dropDownValueVisitor, widget.llEquips);
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => GamePlayMain(teamList),
          ));
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
  }
}
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

  static NavigationHandlerTest nh;

  List<String> getTeams(){
    List<String> teams = <String>[];
    for(int i = 0; i<widget.llEquips.length; i++){
      teams.add(widget.llEquips[i].name);
    }
    return teams;
  }

  void getTeamPlayerListHome (String teamName, List<Team> _teamList ){
    var _localTeamList = <Team>[];
    _localTeamList = _teamList.where((team)=>team.name==teamName).toList();
    for(int i = 0;i<_localTeamList[0].playerlist.length; i++){
      _localTeamList[0].playerlist[i].matchPlace = 'home';
    }
    this.teamList.add(_localTeamList[0]);
  }

  void getTeamPlayerListAway (String teamName, List<Team> _teamList ){
    var _localTeamList = <Team>[];
    _localTeamList = _teamList.where((team)=>team.name==teamName).toList();
    for(int i = 0;i<_localTeamList[0].playerlist.length; i++){
      _localTeamList[0].playerlist[i].matchPlace = 'visitor';
    }
    this.teamList.add(_localTeamList[0]);
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
          getTeamPlayerListHome(dropDownValueHome, widget.llEquips);
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
          getTeamPlayerListAway(dropDownValueVisitor, widget.llEquips);
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      body:
      Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(
              "assets/Images/basketball_court.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
      child:
      SingleChildScrollView(
        child:
        Row(
            children:[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(50),
                    padding: EdgeInsets.only(top: 50),
                    child: dropDownListHome(),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(50),
                    padding: EdgeInsets.only(top: 50),
                    child: dropDownListVisitor(),
                  ),
                ],
              )
            ]
        ),
      ),
      ),
    );
  }
}
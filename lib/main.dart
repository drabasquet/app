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
import 'package:dra/DropdownSelectTeam.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  final teamList = <Team>[];

  final _currentIndex = 0;
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    void addTeam (String teamName, List<Jugador> _playerList )async{
      var _localPlayerList = <Jugador>[];

      _localPlayerList = _playerList.where((jugador)=>jugador.team==teamName).toList();


      this.teamList.add(
          Team(name:teamName, playerlist: _localPlayerList)
      );
      print('executed ' + this.teamList[0].playerlist[0].playerName);
    }

    void addTeams() async{
      var _playerList = <Jugador>[];
      var _nameTeamsList = <String>[];
      _playerList = await dbHelper.getJugadores();
      for (var i = 0; i < (_playerList.length); i++) {
        String word = _playerList[i].team;
        if (_nameTeamsList.contains(word)) {
        } else {
          _nameTeamsList.add(
              word);
        }
      }

      for (var i = 0; i < (_nameTeamsList.length); i++) {
        addTeam(_nameTeamsList[i], _playerList);
      }

    }


    addTeams();
    final playerListtttt = List<Jugador>();
    this.teamList.add(
      Team(name:'dra',playerlist: playerListtttt)
    );
    return MaterialApp(
      title: 'Dra App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Dra. App Home Page', teamList: teamList, currentIndex: _currentIndex),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.teamList, this.currentIndex}) : super(key: key);
  String title;
  List teamList;
  int currentIndex;
  @override

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyHomePage> {


  void onTabTapped(int index) {
    setState(() {
      widget.currentIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pageChanged(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  bool _isVisible () {
    if (widget.currentIndex==3){
      return false;
    }
    else {
      return true;
    }
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView(){
    print(widget.currentIndex);
    return PageView(
        controller:
        PageController(
          initialPage: widget.currentIndex,
          keepPage: true,
        ),
        onPageChanged: (index) {
          pageChanged(index);
        },
      children: <Widget>[
        NavigationHandlerTest(widget.teamList),
        Equipo(widget.teamList),
        NavigationHandler(Colors.yellow),
        DropdownSelectTeam(widget.teamList),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    return Scaffold(
      /*appBar: AppBar(
        //title: Text(widget.title),
        centerTitle: true,
      ),*/
      body: buildPageView(),//_children[_currentIndex],
      bottomNavigationBar: AnimatedContainer(//new Theme(
          height: _isVisible() ? 56.0 : 0.0,
          duration: Duration(milliseconds: 500),
          /*data: Theme.of(context).copyWith(
            canvasColor: Colors.blueAccent, //background color
            primaryColor: Colors.green, // selected items color
            textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white)) //unselected item color
          ),*/
          child: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              onTabTapped(index);
            },
            currentIndex: widget.currentIndex,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text('Home')
              ),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.group_add),
                  title: new Text('Teams')
              ),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.assessment),
                  title: new Text('Stats')
              ),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.add),
                  title: new Text('New game')
              )
            ],
          )
      ),
    );
  }
}

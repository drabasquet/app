import 'package:dra/CrearEquipo2.dart';
import 'package:dra/Jugador.dart';
import 'package:dra/NavigationHandlerTest.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'NavigationHandler.dart';
import 'Team.dart';
import 'Equipo.dart';
import 'app.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  var _playerList = <Jugador>[];
  void submit2() {
      _playerList.add( Jugador('d',1,0,0,0,'home',1));
      _playerList.add( Jugador('r',2,0,0,0,'home',2));
      _playerList.add( Jugador('e',3,0,0,0,'home',3));
      _playerList.add( Jugador('a',4,0,0,0,'home',4));
      _playerList.add( Jugador('m',5,0,0,0,'home',5));

  }

  final _teamList = <Team>[];//<Team>[];

  void submit3() {
    _teamList.add(Team(name: 'dra', playerlist: _playerList));
    _teamList.add(Team(name: 'rivals', playerlist: _playerList));
  }

  //final newTeam =Team(name: 'dra', playerlist: <Jugador>[]);

  final _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    submit2();
    submit3();
    return MaterialApp(
      title: 'Dra App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Dra. App Home Page', teamList: _teamList, currentIndex: _currentIndex),
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
        NavigationHandlerTest(teamList: widget.teamList),
        Equipo(widget.teamList),
        //NavigationHandler(Colors.red),
        NavigationHandler(Colors.yellow),
        GamePlayMain(widget.teamList),
        //NavigationHandler(Colors.purple)
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
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
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

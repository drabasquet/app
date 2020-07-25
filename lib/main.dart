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

  final newTeam =Team(name: 'dra', playerlist: <Jugador>[]);

  final _teamList = <Team>[];//<Team>[];



  final _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blueAccent, //background color
            primaryColor: Colors.green, // selected items color
            textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white)) //unselected item color
          ),
          child: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              onTabTapped(index);
            },
            currentIndex: widget.currentIndex,
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

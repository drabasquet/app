import 'package:flutter/material.dart';
import 'Jugador.dart';
import 'Equipo.dart';
import 'Team.dart';
import 'db/database_helper.dart';
import 'dart:async';
import 'package:dra/main.dart';


class ListaJugadoresForm extends StatefulWidget {
  List<Team> teamList ;
  String name;
  ListaJugadoresForm(this.teamList,this.name);
  @override
  ListaJugadoresFormState createState() => ListaJugadoresFormState();
}

class ListaJugadoresFormState extends State<ListaJugadoresForm> {
  final dbHelper = DatabaseHelper.instance;
  var _playerList = <Jugador>[];
  bool showSaveTeamName;
  bool showForm = false;
  var command='ShowTeamSection';
  @override
  void initState(){
    super.initState();
    if (widget.name==null){
      _playerList = <Jugador>[];
    }else{
      int index = widget.teamList.indexWhere((name)=>name.name==widget.name);
      print(index);
      print(widget.teamList[index].playerlist);
      _playerList=widget.teamList[index].playerlist;
      print(_playerList);
    }

    if (widget.name==null){
      showSaveTeamName= true;
    }else{
      showSaveTeamName= false;
    }

  }

  void submit2(String _name, int _number) async {
    int id= await _insert(_name, _number,widget.name);
    setState(() {
      _playerList.add(
        Jugador(_name,_number,0,0,0,widget.name,_number,id),
      );
    });
    print(await dbHelper.getJugadores());
  }

  Future<int> _insert(String _name, int _number, String _team) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : _name,
      DatabaseHelper.columnNumber  : _number,
      DatabaseHelper.columnTeam :_team
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    return (id);
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows  :');
    allRows.forEach((row) => print(row));
  }

  void insertTeamName(String _name) {
    widget.name=_name;
    setState(() {
      showSaveTeamName = false;
    }
    );
  }

  void _delete(int id) async {
    print(id);
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  void safeWithName (String _name, List<Jugador> _playerlist) {

    _query();
    int index = widget.teamList.indexWhere((name)=>name.name==_name);
    if (index==-1){
      widget.teamList.add(
        Team(name: _name, playerlist: _playerlist),
      );
    }else{
      _playerList=widget.teamList[index].playerlist;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'Dra. App Home Page', teamList: widget.teamList, currentIndex: 1,),
      ),
    );
  }

  void resetListNew() {
    setState(() {});
  }
  void resetList() {
    _query();
    int index = widget.teamList.indexWhere((name)=>name.name==widget.name);
    print(widget.teamList[index].playerlist);
    _playerList=widget.teamList[index].playerlist;

    widget.teamList.add(
      Team(name: widget.name, playerlist: _playerList),
    );


    setState(() {});
  }

  void addAnotherPlayer() {
    setState(() {
      bool showForm = true;
    });
  }


  Widget _buildlistplayers() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _playerList.length,
      itemBuilder: (context, item) {
        //if (item.isOdd) return Divider();
        final index = item;
        return _buildRow( _playerList[index]);
      },
    );
  }

  Widget _buildRow(Jugador Player) {

    int j = Player.playerNumber;

    return ListTile(
      title: Text(Player.playerName + ' number: ' + '$j'),
      trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.green,
          ),
          onPressed: () {
            _playerList.removeWhere((item) => item.playerNumber == Player.playerNumber);
            resetListNew();
            _delete(Player.id);
          }),
    );
  }

  Widget build(BuildContext context) {

    final formKey2 = GlobalKey<FormState>();
    String _name;
    String _number;
    String numberValidator(String value) {
      if (value == null) {
        return null;
      }
      final n = num.tryParse(value);
      if (n >= 100) {
        return '"$value" is not a valid nuumber';
      }
      return null;
    }

    if (showSaveTeamName==true) {
      command = 'ShowTeamNameCreator';
    }else{
      if (showForm==false){
        command='ShowTeamSection';
      }else {
        print('function');
        command='ShowPlayerForm';

      }
    }


    switch(command) {
      case 'ShowTeamSection':
        return Scaffold(
            appBar: AppBar(
              title: Text('jugadoores list'),
            ),
            body: _buildlistplayers(),
            floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width*0.8,
                    color: Colors.deepOrangeAccent,
                    child: FlatButton(
                      child: Text('Save team'),
                      onPressed: () {
                        if (widget.name==null){
                          showSaveTeamName=true;
                          resetList();
                        }else{
                          safeWithName(widget.name, _playerList);
                        }
                      },
                    ),
                  ),

                  FloatingActionButton(
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        showForm = true;
                        addAnotherPlayer();
                      }),
                ]));
        break;
      case 'ShowPlayerForm':
        print('CACA');
        return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: formKey2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                          decoration:
                          InputDecoration(labelText: 'Name of the player:'),
                          validator: (input) =>
                          !input.contains('@') ? 'Not a valid Email' : null,
                          onSaved: (String input) {
                            _name = input;
                          }),
                      new TextFormField(
                        decoration:
                        InputDecoration(labelText: 'Number of the player:'),
                        keyboardType: TextInputType.number,
                        validator: numberValidator,
                        textAlign: TextAlign.left,
                        onSaved: (input) => _number = input,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton(
                              onPressed: () {
                                formKey2.currentState.save();
                                showForm = false;
                                submit2(_name, int.parse(_number));
                              },
                              child: Text('Submit'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
        break;
      case 'ShowTeamNameCreator':
        return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: formKey2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                          decoration:
                          InputDecoration(labelText: 'Name of the team:'),
                          validator: (input) =>
                          !input.contains('@') ? 'Not a valid Email' : null,
                          onSaved: (String input) {
                            _name = input;
                          }),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton(
                              onPressed: () {
                                formKey2.currentState.save();
                                showSaveTeamName = false;
                                insertTeamName(_name);
                              },
                              child: Text('Submit'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));

        break;
      default:
        print('No Scaffold Found');
    // code block
    }


  }
}


class Player {
  String _name;
  String _number;

  Player(this._name, this._number);
}

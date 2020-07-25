import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'RegisterPage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'MultiForm.dart';
import 'RegisterPage.dart';
import 'CrearEquipo.dart';
import 'CrearEquipo2.dart';
import 'User.dart';
import 'ListaJugadoresForm.dart';
import 'Equipo.dart';
import 'Team.dart';
import 'Jugador.dart';
import 'app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _teamList = <Team>[];
   return Home(_teamList);
  }
}
class Home extends StatelessWidget {
  List<Team> teamList ;
  Home(this.teamList);
String noName =null;

// This widget is the root of your application.
@override
Widget build(BuildContext context) {

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

//    _teamList.add(
//      Team(name: '', playerlist: _playerList),
//    );
  return MaterialApp(
    title: 'Flutter De0mo',
    theme: ThemeData(
      // This is the theme of your application.
      primarySwatch: Colors.blue,
    ),
    routes: <String, WidgetBuilder>{
      "/inicio": (BuildContext context) => Inicio(),
      "/equipo": (BuildContext context) => Equipo(this.teamList),
      "/jugador": (BuildContext context) => JugadorSection(),
      "/partido": (BuildContext context) => GamePlayMain(this.teamList),
      "/crearequipo": (BuildContext context) => CrearEquipo(this.teamList),
      "/crearpartido": (BuildContext context) => CrearPartido(),
      "/crearjugador": (BuildContext context) => CrearJugador(),
      "/editarjugador": (BuildContext context) => ListaJugadoresForm(this.teamList,noName),
    },
    home: Inicio(),
  );
}
}



class CrearEquipo extends StatelessWidget {
  List<Team> teamList ;
  CrearEquipo(this.teamList);
  @override
  Widget build(BuildContext context) {
    String noName =null;
    return new Scaffold(
      body: Center(
        child: ListaJugadoresForm(this.teamList,noName),
      ),
    );
  }
}

class ListaJugadores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Creador de equipos"),
      ),
      body: Center(
        child: MyCustomForm(),
      ),
    );
  }
}

class CrearPartido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Creador de equipoos"),
      ),
      body: Center(
        child: CrearJugador(),
      ),
    );
  }
}

class CrearJugador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Creador de equiposs"),
      ),
      body: Center(
        child: CrearEquipo2(),
      ),
    );
  }
}

// Define un widget de formulario personalizado
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

formItemsDesign(icon, item) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Card(child: ListTile(leading: Icon(icon), title: item)),
  );
}

// Define una clase de estado correspondiente. Esta clase contendrá los datos
// relacionados con el formulario.
class MyCustomFormState extends State<MyCustomForm> {
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un `GlobalKey<FormState>`, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Cree un widget Form usando el _formKey que creamos anteriormente
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            'Nombre del equipo',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              // El validator recibe el texto que el usuario ha digitado
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  return 'well done';
                }
              },
            ),
          ),
          Container(
            child: Text(
              'Jugadores',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(10.0),
            color: Colors.amber,
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Container(),
                ],
              ),
              Container(
                child: Text(
                  'Numberr',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: Text(
                  'Position',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.rectangle,
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              // Validate devolverá true si el formulario es válido, o false si
              // el formulario no es válido.
              if (_formKey.currentState.validate()) {
                // Si el formulario es válido, muestre un snackbar. En el mundo real, a menudo
                // desea llamar a un servidor o guardar la información en una base de datos
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class JugadorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Jugadores"),
      ),
      body: Center(
        child: Text("Players Sectionn"),
      ),
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/crearjugador");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Partido extends StatelessWidget {
  final _teamList = <Team>[];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Partido"),
      ),
      body: Center(
        child: Text("go go go"),
      ),
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Equipo(_teamList),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Inicio extends StatelessWidget {

  final _playerlist = <Jugador>[];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/Images/lance.jpg'))),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.pushNamed(context, "/inicio");

                          },
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Text(
                                  "INICIO",
                                  textAlign: TextAlign.center,
                                ),
                              ))),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.pushNamed(context, "/equipo");
                          },
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Text(
                                  "EQUIPOS",
                                  textAlign: TextAlign.center,
                                ),
                              ))),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.pushNamed(context, "/jugador");
                          },
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Text(
                                  "JUGADORES",
                                  textAlign: TextAlign.center,
                                ),
                              ))),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.pushNamed(context, "/partido");
                          },
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Text(
                                  "PARTIDOS",
                                  textAlign: TextAlign.center,
                                ),
                              ))),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

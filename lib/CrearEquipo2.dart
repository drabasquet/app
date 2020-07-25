import 'package:flutter/material.dart';
import 'ListaJugadoresForm.dart';


class CrearEquipo2 extends StatefulWidget {
  CrearEquipo2({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class Player {

  String _name;
  String _number;


  Player(this._name,this._number);

}


class _MyHomePageState extends State<CrearEquipo2> {
  final formKey34 = GlobalKey<FormState>();
  String _name;
  String _number;


  String numberValidator(String value) {
    if(value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if(n >= 100) {
      return '"$value" is not a valid nuumber';
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body:  SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey34,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Name of the player:'
                    ),
                    validator: (input) => !input.contains('@') ? 'Not a valid Email' : null,
                    onSaved: (input) => _name = input,
                  ),
                   TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Number of the player:'
                    ),
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
                            _submit();

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
  }

  void _submit(){

    setState(() {
      bool form = false;
    });
  }
}
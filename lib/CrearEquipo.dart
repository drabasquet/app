import 'package:flutter/material.dart';

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
                  'Number',
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
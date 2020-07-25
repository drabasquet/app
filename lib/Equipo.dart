import 'package:flutter/material.dart';
import 'main_ric.dart';
import 'Team.dart';
import 'ListaJugadoresForm.dart';

class Equipo extends StatefulWidget {
  List<Team> teamList;
  Equipo(this.teamList);
  @override
  EquipoState createState() => EquipoState();
}
class EquipoState extends State<Equipo> {

  void resetList() {
    setState(() {});
  }



  Widget _buildlistteams() {

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.teamList.length,
      itemBuilder: (context, item) {
        //if (item.isOdd) return Divider();
        final index = item;
        return _buildRow(widget.teamList[index]);
      },
    );
  }

  Widget _buildRow(Team Team) {

    return ListTile(
      title: Text(Team.name ),
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => ListaJugadoresForm(widget.teamList,Team.name),
        ),
        );
      },
      trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.green,
          ),
          onPressed: () {
            widget.teamList.removeWhere((item) => item.name == Team.name);
            resetList();
          }),
    );
  }
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(widget.teamList),
              ),
            );
          }),
          title: Text('Team List'),
        ),
        body: _buildlistteams(),
        backgroundColor: Colors.blueGrey.shade200,
        floatingActionButton:
        Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [

              FloatingActionButton(
                  child: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CrearEquipo(widget.teamList),
                      ),
                    );
                  }),
            ]));



  }
}
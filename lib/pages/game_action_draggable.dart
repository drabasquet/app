import 'package:flutter/material.dart';
import 'player_widget.dart';
import '../Jugador.dart';
class GameAction extends StatelessWidget {
  final int _id;
  final Offset _offset;
  GameAction(this._id, this._offset);
  @override
  Widget build(BuildContext context) {
    Map actionDecodeMeaning = {
      1: '+1',
      2: '+2',
      3: '+3',
      4: '+1m',
      5: '+2m',
      6: '+3m',
    };
    Map actionDecodeValue = {
      1: 1,
      2: 2,
      3: 3,
      4: 0,
      5: 0,
      6: 0,
    };
    return Positioned(
        left: _offset.dx,
        top: _offset.dy,
        child: Draggable(
          data: [_id, actionDecodeMeaning[_id], actionDecodeValue[_id], Jugador('agus',999, 0, 0, 0, '', 0)],
          child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.purple[900], width: 5)),
              child: Text(
                actionDecodeMeaning[_id],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          feedback: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.purple[900], width: 5)),
              child: Text(
                actionDecodeMeaning[_id],
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              )),
          childWhenDragging: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey[600],
                  border: Border.all(color: Colors.purple[900], width: 5)),
              child: Text(
                actionDecodeMeaning[_id],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              )),
        ));
  }
}

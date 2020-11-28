import 'package:flutter/material.dart';
import 'db/database_provider.dart';


class Jugador{
  String playerName;
  int playerNumber;
  int playerPoints;
  int playerAssists;
  int playerRebounds;
  String team;
  int playerPosition;
  int id;

  Jugador(this.playerName, this.playerNumber, this.playerPoints, this.playerAssists,
      this.playerRebounds, this.team, this.playerPosition, this.id);

  Map<String, dynamic> toMap(){
    return {
      'id':playerPosition,
      'PlayerName': playerName,
      'PlayerNumber': playerNumber,
      'team': team
    };
  }

  @override
  String toString() {
    return 'Jugador{playerPos: $playerPosition, PlayerNname: $playerName, PlayerNumber: $playerNumber}';
  }
}




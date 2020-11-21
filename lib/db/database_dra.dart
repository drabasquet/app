import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Jugador.dart';


void main() async {
  final database = openDatabase(
    // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
    // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
    // construida para cada plataforma.
    join(await getDatabasesPath(), 'jugador_database.db'),
    // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar dogs
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE jugadores(number INTEGER PRIMARY KEY, name TEXT, points INTEGER)",
      );
    },
    // Establece la versión. Esto ejecuta la función onCreate y proporciona una
    // ruta para realizar actualizacones y defradaciones en la base de datos.
    version: 1,
  );

  Future<void> insertDog(Jugador player) async {
    // Obtiene una referencia de la base de datos
    final Database db = await database;

    // Inserta el Dog en la tabla correcta. También puede especificar el
    // `conflictAlgorithm` para usar en caso de que el mismo Dog se inserte dos veces.
    // En este caso, reemplaza cualquier dato anterior.
    await db.insert(
      'jugadores',
      player.toMap(),
    );
  }

  Future<List<Jugador>> players() async {
    // Obtiene una referencia de la base de datos
    final Database db = await database;

    // Consulta la tabla por todos los Dogs.
    final List<Map<String, dynamic>> maps = await db.query('players');

    // Convierte List<Map<String, dynamic> en List<Dog>.
    return List.generate(maps.length, (i) {
      return Jugador(
          maps[i]['PlayerName'],
          maps[i]['PlayerNumber'],
          0,
          0,
          0,
          'home',
          1,
        999
      );
    });
  }

  Future<void> updateDog(Jugador player) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Actualiza el Dog dado
    await db.update(
      'jugadores',
      player.toMap(),
      // Aseguúrate de que solo actualizarás el Dog con el id coincidente
      where: "id = ?",
      // Pasa el id Dog a través de whereArg para prevenir SQL injection
      whereArgs: [player.playerNumber],
    );
  }
}

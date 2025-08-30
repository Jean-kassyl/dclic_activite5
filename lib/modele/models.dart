import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Redacteur {
  final int? id;
  final String nom;
  final String prenom;
  final String email;

  Redacteur({required this.id, required this.nom, required this.prenom, required this.email});
  Redacteur.sansId({this.id,required this.nom, required this.prenom, required this.email});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email
    };
  }
}


class DatabaseManager {
  dynamic _database;

  Future<void> initialisation() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'redacteurs_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          ''' 
            CREATE TABLE redacteurs (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nom TEXT,
              prenom TEXT,
              email TEXT
            )
          '''
        );
      }
    );
  }

  Future<void> insertRedacteur (Redacteur redacteur) async{
      await _database.insert(
        'redacteurs',
        redacteur.toMap()
      );
  }

  Future<void> updateRedacteur(Redacteur redacteur) async {
    await _database.update(
      'redacteurs',
      redacteur.toMap(),
      where: 'id = ?',
      whereArgs: [redacteur.id]
    );
  }

  Future<void> deleteRedacteur(int id) async {
    await _database.delete(
      'redacteurs',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<List<Redacteur>> getAllRedacteurs() async {
    List<Map<String, dynamic>> maps = await _database.query('redacteurs');

    return List.generate(maps.length, (i) {
        return Redacteur(
          id: maps[i]['id'],
          nom: maps[i]['nom'],
          prenom: maps[i]['prenom'],
          email: maps[i]['email']
        );
    });


  }

}
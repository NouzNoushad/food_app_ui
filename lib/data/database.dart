import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Database? db;

  Future open() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'foodCart.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE foodCarts (
          id integer primary key autoIncrement,
          image varchar(255) not null,
          title varchar(255) not null,
          price real not null,
          count int not null
        );
      ''');
    });
  }
}

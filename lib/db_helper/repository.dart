import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_crud_operation/db_helper/database_connection.dart';

class Repository {
  late DataBaseConnection _dataBaseConnection;

  Repository() {
    _dataBaseConnection = DataBaseConnection();
  }

  // Singleton Database -> While installing the app once database is created,
  // no more database is created again and again

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _dataBaseConnection.setDatabase();
      return _database;
    }
  }

  // Insert User
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  // Read All record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // Read a Single Record by ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  // Update User
  updateData(table, data) async {
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  // Delete User
  deleteDataById(table, itemId) async {
    var connection =  await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }

}
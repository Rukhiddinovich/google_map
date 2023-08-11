import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/models/user_model.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("defaultDatabase.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const doubleType = "REAL DEFAULT 0.0";

    await db.execute('''
    CREATE TABLE ${LocationUserModelFields.userLocationTable}(
    ${LocationUserModelFields.id} $idType,
    ${LocationUserModelFields.lat} $doubleType,
    ${LocationUserModelFields.long} $doubleType,
    ${LocationUserModelFields.city} $textType,
    ${LocationUserModelFields.created} $textType
    );
    ''');
  }

//-------------------------------LocationUserModel SERVICE------------------------------------------
  static Future<LocationUserModel> insertLocationUser(
      LocationUserModel locationUserModel) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        LocationUserModelFields.userLocationTable, locationUserModel.toJson());

    return locationUserModel.copyWith(id: id);
  }

  static Future<List<LocationUserModel>> getAllLocationUser() async {
    List<LocationUserModel> allLocationUser = [];
    final db = await getInstance.database;
    allLocationUser =
        (await db.query(LocationUserModelFields.userLocationTable))
            .map((e) => LocationUserModel.fromJson(e))
            .toList();

    return allLocationUser;
  }

  static deleteLocationUser(int id) async {
    final db = await getInstance.database;
    db.delete(
      LocationUserModelFields.userLocationTable,
      where: "${LocationUserModelFields.id} = ?",
      whereArgs: [id],
    );
  }

  static deleteAllLocationUsers() async {
    final db = await getInstance.database;
    db.delete(
      LocationUserModelFields.userLocationTable,
    );
  }
}

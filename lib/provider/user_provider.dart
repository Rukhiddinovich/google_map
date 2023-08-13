import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/models/user_model.dart';


class LocalDatabase{
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase(){
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async{
    if(_database !=null){
      return _database!;
    }else{
      _database = await _initDB("user_addresses.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName)async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,dbName);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db, int version)async{
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const doubleType = "REAL DEFAULT 0.0";

    await db.execute('''
    CREATE TABLE ${UserAddressFields.userLocationTable}(
    ${UserAddressFields.id} $idType,
    ${UserAddressFields.lat} $doubleType,
    ${UserAddressFields.long} $doubleType,
    ${UserAddressFields.address} $textType,
    ${UserAddressFields.created} $textType
    );
    ''');
  }
//-------------------------------LocationUserModel SERVICE------------------------------------------
  static Future<UserAddress> insertUserAddress(UserAddress locationUserModel) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        UserAddressFields.userLocationTable, locationUserModel.toJson());


    return locationUserModel.copyWith(id: id);
  }

  static Future<List<UserAddress>> getAllUserAddresses() async {
    List<UserAddress> allLocationUser = [];
    final db = await getInstance.database;
    allLocationUser = (await db.query(UserAddressFields.userLocationTable))
        .map((e) => UserAddress.fromJson(e))
        .toList();

    return allLocationUser;
  }

  static deleteUserAddress(int id) async {
    final db = await getInstance.database;
    db.delete(
      UserAddressFields.userLocationTable,
      where: "${UserAddressFields.id} = ?",
      whereArgs: [id],
    );
  }

  static deleteAllAddresses() async {
    final db = await getInstance.database;
    db.delete(
      UserAddressFields.userLocationTable,
    );
  }
}

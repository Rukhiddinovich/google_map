import 'package:sqflite/sqflite.dart';
import '../models/map/map_model.dart';

class DatabaseHelper {
  static late Database _database;

  static Future<void> initializeDatabase() async {
    _database = await openDatabase(
      'addresses.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE addresses (
            id INTEGER PRIMARY KEY,
            name TEXT,
            latitude REAL,
            longitude REAL
          )
        ''');
      },
    );
  }

  static Future<void> insertAddress(Address address) async {
    await _database.insert('addresses', {
      'name': address.name,
      'latitude': address.location.latitude,
      'longitude': address.location.longitude,
      'address': address.address
    });
  }

  static Future<List<Address>> getAddresses() async {
    final db = _database;
    final List<Map<String, dynamic>> maps = await db.query('addresses');

    return List.generate(maps.length, (i) {
      return Address(
        id: maps[i]['id'],
        name: maps[i]['name'],
        location: Location(
          latitude: maps[i]['latitude'],
          longitude: maps[i]['longitude'],
        ),
        address: maps[i]['address'],
      );
    });
  }

  static Future<void> deleteAddress(int id) async {
    final db = _database;
    await db.delete('addresses', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteAllAddresses() async {
    final db = _database;
    await db.delete('addresses');
  }
}

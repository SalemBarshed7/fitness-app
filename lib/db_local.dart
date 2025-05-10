import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/Catogrymodel.dart';

class LocalDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'categories.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY,
          name TEXT,
          image TEXT
        )
      ''');
    });
  }

  static Future<void> insertCategories(List<dynamic> categories) async {
    final db = await database;
    await db.transaction((txn) async {
    final batch = txn.batch();

    batch.delete('categories');  

    for (var item in categories) {
      batch.insert(
        'categories',
        {
          'id': item['id'],
          'name': item['name'],
          'image': item['image'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  });
}


  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    return await db.query('categories');
  }
}

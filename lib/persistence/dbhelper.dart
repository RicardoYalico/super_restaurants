import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:super_restaurants/models/restaurant.model.dart';

class DbHelper {
  final int version = 1;
  Database? db;
  static final DbHelper dbHelper = DbHelper.internal();
  DbHelper.internal();

  factory DbHelper() {
    return dbHelper;
  }

  Future<Database> openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), 'super_restaurants.db'),
          onCreate: (database, version) {
            database.execute(
                'CREATE TABLE restaurants(id INTEGER PRIMARY KEY, title TEXT, poster TEXT)');
          }, version: version);
    return db!;
  }


  Future<int> insertList(RestaurantsModel list) async {
    int id = await db!.insert('restaurants', list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<RestaurantsModel>> getLists() async {
    final List<Map<String, dynamic>> maps = await db!.query('restaurants');
    return List.generate(maps.length, (i) {
      return RestaurantsModel(
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['poster'],
        maps[i]['isFavorite'],
      );
    });
  }

  Future<int> deleteProduct(RestaurantsModel item) async {
    // await openDb();

    int result =
    await db!.delete("restaurants", where: "id=?", whereArgs: [item.id]);
    return result;
  }

  Future<bool> isFavorite(RestaurantsModel item) async {
    final List<Map<String, dynamic>> maps =
    await db!.query('restaurants', where: 'id=?', whereArgs: [item.id]);
    return maps.length > 0;
  }
}

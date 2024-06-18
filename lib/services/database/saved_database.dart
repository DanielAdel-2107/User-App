import 'package:firstapp/constance.dart';
import 'package:firstapp/model/savings_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SavingHelper {
  SavingHelper._();
  static final SavingHelper db = SavingHelper._();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'SavedItems.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $savedItemsTable(
            $columnAmenties TEXT NOT NULL,
            $columnArea TEXT NOT NULL,
            $columnBaths TEXT NOT NULL,
            $columnDescription TEXT NOT NULL, // Corrected variable name
            $columnDownPayment TEXT NOT NULL,
            $columnInstallment TEXT NOT NULL, // Corrected variable name
            $columnLocation TEXT NOT NULL,
            $columnPrice TEXT NOT NULL,
            $columnRooms TEXT NOT NULL,
            $columnType TEXT NOT NULL,
            $columnBrokerEmail TEXT NOT NULL, // Corrected variable name
            $columnBrokerPhone TEXT NOT NULL, // Corrected variable name
            $columnPaymentType TEXT NOT NULL
          )
      ''');
    });
  }

  Future<List<SavingsModel>> getAllSavings() async {
    var dbClient = await database;
    List<Map> maps = await dbClient!.query(savedItemsTable);
    List<SavingsModel> lst = maps.isNotEmpty
        ? maps.map((saving) => SavingsModel.fromJson(saving)).toList()
        : [];
    return lst;
  }

  insert(SavingsModel model) async {
    var dbClient = await database;
    await dbClient!.insert(savedItemsTable, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

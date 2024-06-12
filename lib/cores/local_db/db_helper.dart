import 'package:path/path.dart';
import 'package:reminderapp_test/features/home/data/models/reminder_db_model.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String dbName = "reminders.db";
  final String tableName = "reminder";
  final String colId = "id";
  final String colTitle = "title";
  final String colDescription = "description";
  final String colHour = "hour";
  final String colMinute = "minute";

  Database? db;

  Future<void> initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) {});

    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDescription TEXT,$colHour INTEGER,$colMinute INTEGER)");
  }

  insertRecord({required Reminder reminder}) async {
    await initDB();
    String query =
        "INSERT INTO $tableName($colTitle, $colDescription, $colHour, $colMinute) VALUES(?, ?, ?, ?)";
    List args = [
      reminder.title,
      reminder.description,
      reminder.hour,
      reminder.minute
    ];
    await db?.rawInsert(query, args);

    fetchAllRecords();
  }

  Future fetchAllRecords() async {
    await initDB();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<ReminderLocalModel> reminderList =
        data.map((e) => ReminderLocalModel.fromData(data: e)).toList();

    return reminderList;
  }

  Future updateReminder({required ReminderLocalModel reminder}) async {
    await initDB();

    String query =
        "UPDATE $tableName SET $colTitle = ?, $colDescription = ?, $colMinute = ? ,$colHour = ? WHERE $colId = ?";
    List args = [
      reminder.title,
      reminder.description,
      reminder.minute,
      reminder.hour,
      reminder.id
    ];
    await db!.rawUpdate(query, args);

    fetchAllRecords();
  }

  deleteReminder({required int id}) async {
    await initDB();

    String query = "DELETE FROM $tableName WHERE $colId = $id";

    db!.rawDelete(query);

    fetchAllRecords();
  }
}

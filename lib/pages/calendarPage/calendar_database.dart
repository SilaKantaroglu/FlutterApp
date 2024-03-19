import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class Event {
  final DateTime date;
  final String event;

  Event(this.date, this.event);
}

class DatabaseHelper {
  static const String tableEvents = 'events';
  static const String columnId = 'id';
  static const String columnDate = 'date';
  static const String columnEvent = 'event';

  Future<Database> _initializeDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'ajanda.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
          CREATE TABLE $tableEvents (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate TEXT,
            $columnEvent TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> addEvent(Event event) async {
    final db = await _initializeDatabase();
    await db.insert(
      tableEvents,
      {
        columnDate: event.date.toIso8601String(),
        columnEvent: event.event,
      },
    );
  }

  Future<void> deleteEvent(String event) async {
    final db = await _initializeDatabase();
    await db.delete(
      tableEvents,
      where: '$columnEvent = ?',
      whereArgs: [event],
    );
  }

  Future<Map<DateTime, List<dynamic>>> getEvents() async {
    final db = await _initializeDatabase();
    final events = await db.query(tableEvents);
    final eventMap = <DateTime, List<dynamic>>{};
    for (var event in events) {
      final date = DateTime.parse(event[columnDate] as String);
      final eventText = event[columnEvent] as String;
      if (eventMap[date] != null) {
        eventMap[date]!.add(eventText);
      } else {
        eventMap[date] = [eventText];
      }
    }
    return eventMap;
  }
}

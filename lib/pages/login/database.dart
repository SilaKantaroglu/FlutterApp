import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:staj_case/pages/login/database_model.dart';

class DatabaseHelper {
  final databaseName = 'login.db';

  // tables
  String user = ''' 
  CREATE TABLE users ( 
    userId INTEGER PRIMARY KEY AUTOINCREMENT,
    fullName TEXT,
    email TEXT,
    userName TEXT UNIQUE, 
    userPassword TEXT  
  )
  ''';

  // veritabanı bağlantısı
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
    });
  }

// doğrulamak için gereken bağlantı
  Future<bool> authenticate(Users usr) async {
    final Database db = await initDB();

    var res = await db
        .rawQuery("SELECT * FROM users WHERE userName = ? AND userPassword = ?", [usr.userName, usr.userPassword]);

    if (res.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // kayıt ol veritabanına bağlantısı
  Future<int> createUser(Users usr) async {
    final Database db = await initDB();
    return db.insert("users", usr.toMap());
  }

  Future<Map<String, dynamic>?> getUserDetail(String userName) async {
    final Database db = await initDB();
    var res = await db.query("users", where: "userName = ?", whereArgs: [userName]);

    if (res.isNotEmpty) {
      return {
        "fullName": res.first["fullName"],
        "email": res.first["email"],
        "userName": res.first["userName"],
      };
    } else {
      return null;
    }
  }
}

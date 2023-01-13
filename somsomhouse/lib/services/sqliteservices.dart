import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'my.db'), // schema 만 있는 것
      // table 만들기
      onCreate: (database, version) async {
        await database.execute(
            'create table likelist (id integer primary key autoincrement, apartname text)');
      },
      version: 1,
    );
  }

  Future<int> insert(String apartname) async {
    int result = 0;

    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into likelist (apartname) values (?)',
      [apartname],
    );

    return result;
  }

  Future<int> delete(String apartname) async {
    int result = 0;

    final Database db = await initializeDB();
    result = await db.rawDelete(
      'delete from likelist where apartname = ?',
      [apartname],
    );

    return result;
  }

  Future<List<String>> select() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from likelist');
    return queryResult.map((e) => e['apartname'].toString()).toList();
  }

  Future<List<String>> isLike(String apartname) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        'select count(*) from likelist where apartname = ?', [apartname]);
    return queryResult.map((e) => e['count(*)'].toString()).toList();
  }
}

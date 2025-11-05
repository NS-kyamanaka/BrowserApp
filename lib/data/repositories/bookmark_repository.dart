import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/bookmark.dart';

class BookmarkRepository {
  late Database _database;
  static const String _tableName = 'bookmarks';

  Future<void> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'bookmark_db.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            url TEXT NOT NULL,
            date TEXT NOT NULL
          )
          ''');
        //初回はGoogleを登録しておく
        final google = Bookmark.create(
          name: 'Google',
          url: 'https://www.google.com/',
        );
        await db.insert(
          _tableName,
          google.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );
  }

  //データの取得(SELECT)
  Future<List<Bookmark>> getBookmarks() async {
    final List<Map<String, dynamic>> maps = await _database.query(_tableName);
    
    return List.generate(maps.length, (i) {
      return Bookmark.fromMap(maps[i]);
    });
  }

  //データの挿入
  Future<int> insertBookmark(Bookmark bookmark) async {
    return await _database.insert(
      _tableName,
      bookmark.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //データの削除
  Future<int> deleteBookmark(int id) async {
    return await _database.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  //データの更新
  Future<int> updateBookmark(Bookmark bookmark) async {
    final Map<String, dynamic> values = bookmark.toMap();

    return await _database.update(
      _tableName,
      values,
      where: 'id = ?',
      whereArgs: [bookmark.id],
    );
  }
}

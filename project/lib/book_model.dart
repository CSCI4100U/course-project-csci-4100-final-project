import 'db_utils.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:project/book.dart';
class BookModel{
  Future insertBook(Book book) async{
    final db = await DBUtils.init();
    return db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getAllBooks() async{
    final db = await DBUtils.init();
    final List maps = await db.query('books');
    List result = [];
    for (int i = 0; i<maps.length; i++){
      result.add(
        Book.fromMap(maps[i])
      );
    }
    return result;
  }
  Future<int> updateBook(Book book) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    return db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }
  Future<int> deleteBookById(int? id) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    return db.delete(
      'book',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
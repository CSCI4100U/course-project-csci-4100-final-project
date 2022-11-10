import 'db_utils.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:project/book.dart';
class BookModel{
  Future insertBook(Book book) async{
    final db = await DBUtils.init();
    return db.insert(
      'book_items',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  // Need to check book.dart and the fromMap functions
  // and how variables are assigned before this can be finished

  // Future getAllBooks() async{
  //   final db = await DBUtils.init();
  //   final List maps = await db.query('book_items');
  //   List result = [];
  //   for (int i = 0; i<maps.length; i++){
  //     result.add(
  //       Book.fromMap(maps[i])
  //     );
  //   }
  //   return result;
  // }

}
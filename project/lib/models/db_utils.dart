import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    Database database = await openDatabase(
      path.join(await getDatabasesPath(), "movies_books.db"),
      onCreate: (Database db, int version) async{
        // movies
        //   imdb_id: The unique identifier for that movie which is used by IMDB
        //   watched: A boolean value (1 or 0) for whether or not the user has watched that movie
        //   rating: What the user rated the movie on a scale of 1-5

        // books
        db.execute("CREATE TABLE movies(imdb_id VARCHAR PRIMARY KEY, watched INTEGER, rating INTEGER)");
        db.execute ("CREATE TABLE books(id VARCHAR PRIMARY KEY, title TEXT, description TEXT)");
      },
      version: 2,
    );
    return database;
  }
}
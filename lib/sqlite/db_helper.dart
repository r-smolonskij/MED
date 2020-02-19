import 'dart:async';
import 'dart:ffi';
import 'dart:io' ;
import 'package:med/sqlite/definition.dart';
import 'package:med/sqlite/source.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'field.dart';
import 'word.dart';
import 'relationship.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class DBHelper {

  //static const String ID = 'id';
  //static const String NAME = 'name';
  //static const String fieldsTABLE = 'fields';
  //static const String DB_NAME = 'medDB.db';
  static final DBHelper _instance = new DBHelper.internal();
  factory DBHelper() => _instance;
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DBHelper.internal();
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'med.db');

    // Only copy if the database doesn't exist
    //if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
    // Load database from asset and copy
    ByteData data = await rootBundle.load(join('assets', 'med.db'));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Save copied asset to documents
    await new File(path).writeAsBytes(bytes);
    //}
    var ourDb = await openDatabase(path);
    return ourDb;
  }
//  initDb() async {
//    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, DB_NAME);
//    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//
//    return db;
//  }

//  _onCreate(Database db, int version) async {
//    await db.execute(
//        "CREATE TABLE fields ( id INTEGER , titleLV TEXT, titleENG TEXT)");
//    await db.execute(
//        "CREATE TABLE words ( id INTEGER PRIMARY KEY, wordLV TEXT, wordENG TEXT, )");
//    await db.execute(
//        "CREATE TABLE words_field_relationship ( relationshipID INTEGER PRIMARY KEY, wordID INTEGER, fieldID INTEGER, bookmarks TEXT, definitionLV TEXT, source TEXT, sourceID INTEGER, sourceLink TEXT, examplesLV TEXT, examplesLVSource TEXT, examplesLVSourceID INTEGER , examplesENG TEXT, examplesENGSource TEXT, examplesENGSourceID INTEGER   )");
//  }

//  /*Fields table functions*/
//  Future<Field> saveField(Field field) async {
//    var dbClient = await db;
//    await dbClient.transaction((txn) async {
//      var query = "INSERT INTO fields (id, titleLV, titleENG) VALUES (" + field.id.toString() + ", '" + field.titleLV + "', '" + field.titleENG + "')";
//      return await txn.rawInsert(query);
//    });
//  }
  Future<List<Source>> getSources() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM sources");
    List<Source> sources = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        sources.add(Source.fromMap(maps[i]));
      }
    }
    return sources;
  }

  Future<List<Field>> getFields() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM fields");
    List<Field> fields = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        fields.add(Field.fromMap(maps[i]));
      }
    }
    return fields;
  }

  Future<int> getFieldsCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM fields'));
  }

  Future<Field> getFieldByID(int ID) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM fields WHERE fieldID = " + ID.toString());
    List<Field> fields = [];
    fields.add(Field.fromMap(maps[0]));
    return fields[0];
  }

  /*Words table functions*/

//  Future<Word> saveWord(Word word) async {
//    var dbClient = await db;
//    await dbClient.transaction((txn) async {
//      var query = "INSERT INTO words (id, wordLV, wordENG, typeID) VALUES (" + word.wordID.toString() + ", '" + word.wordLV + "', '" + word.wordENG + "', '" + word.typeID.toString() + "')";
//      return await txn.rawInsert(query);
//    });
//  }

  Future<Word> getWordByID(int ID) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM words WHERE wordID = " + ID.toString());
    List<Word> words = [];
    words.add(Word.fromMap(maps[0]));
    return words[0];
  }

  Future<List<Word>> getWords() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM words");
    List<Word> words = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        words.add(Word.fromMap(maps[i]));
      }
    }
    return words;
  }

  Future<int> getWordsCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM words'));
  }

  /*Words-Fields Relationship table functions*/

  Future<Field> saveWordFieldsRelationship(
      int relationshipID, int wordID, int fieldID) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO relationship (relationshipID, wordID, fieldID) VALUES (" +
              relationshipID.toString() +
              ", " +
              wordID.toString() +
              ", " +
              fieldID.toString() +
              ")";
      return await txn.rawInsert(query);
    });
  }

  Future<List<Word>> getWordsByFieldID(int fieldID) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT *  FROM words INNER JOIN relationship ON relationship.wordID = words.wordID WHERE relationship.fieldID = " +
            fieldID.toString() +
            " ORDER BY words.wordID");
    List<Word> words = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        words.add(Word.fromMap(maps[i]));
      }
    }
    return words;
  }

  Future<List<Field>> getFieldsByWordID(int wordID) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT *  FROM fields INNER JOIN relationship ON relationship.fieldID = fields.fieldID WHERE relationship.wordID = " +
            wordID.toString());
    List<Field> fields = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        fields.add(Field.fromMap(maps[i]));
      }
    }
    return fields;
  }

  Future<Definition> getDefinitionByWordID(int wordID) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT *  FROM words INNER JOIN definitions ON definitions.wordID = words.wordID WHERE definitions.wordID = " +
            wordID.toString() +
            "");
    List<Definition> definitions = [];
    definitions.add(Definition.fromMap(maps[0]));
    return definitions[0];
  }
  Future<int> getDefinitionCount(int wordID) async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM definitions WHERE wordID ='+  wordID.toString()));
  }
  Future<List<Word>> getWordsByFieldIDandType(int fieldID, String type) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT *  FROM words  WHERE words.fieldID = " +
            fieldID.toString() +
            " AND words.wordType = " + type);
    List<Word> words = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        words.add(Word.fromMap(maps[i]));
      }
    }
    return words;
  }
  Future<int> getWordsCountByFieldIDandType(int fieldID, String type) async {
    var dbClient = await db;

    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM words INNER JOIN relationship ON relationship.wordID = words.wordID WHERE relationship.fieldID = ' + fieldID.toString()+ ' AND words.wordType = "' + type+'"'));
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}

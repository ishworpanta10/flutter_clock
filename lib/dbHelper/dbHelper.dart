import 'dart:io';
import 'package:flutter_clock/model/alarm_info.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // commnly used variables
  static final _dbName = 'flutterClock.db';
  static final _dbVersion = 1;

  // Making Singleton class
  static DatabaseHelper _instance; // Singleton DatabaseHelper
  DatabaseHelper._createInstance(); //Named Constructor to create _instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_instance == null) {
      //this is executed only once, singleton Object
      _instance = DatabaseHelper._createInstance();
    }
    return _instance;
  }

  // getting _instance of db from sqflite (Singleton database)
  static Database _database;

// getter for db
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initializeDatabase();
    return _database;
  }

  // initiate db for for time that app run
  Future<Database> _initializeDatabase() async {
    //getting directory path for android and ios
    Directory directory = await getApplicationDocumentsDirectory();
    String dbpath = join(directory.path, _dbName);
    return await openDatabase(dbpath, version: _dbVersion, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    // creating table
    await db.execute(''' 
      CREATE TABLE ${AlarmInfo.tableName}(
      ${AlarmInfo.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AlarmInfo.columnTitle} TEXT NOT NULL,
      ${AlarmInfo.columnDateTime} TEXT NOT NULL,
      ${AlarmInfo.columnisPending} INTEGER ,
      ${AlarmInfo.columnColorIndex} INTEGER)  
       ''');
  }

  // insert
  Future<int> insert(AlarmInfo alarm) async {
    Database db = await _instance.database;
    var result = await db.insert(AlarmInfo.tableName, alarm.toMap());
    print("Result: $result");
    return result;
  }

  // Read
  Future<List<AlarmInfo>> queryAll() async {
    Database db = await _instance.database;
    List<Map> alarmList = await db.query(AlarmInfo.tableName);
    return alarmList.length == 0
        ? []
        : alarmList.map((alarm) => AlarmInfo.fromMap(alarm)).toList();
  }

  // update
  Future<int> update(AlarmInfo alarm) async {
    Database db = await _instance.database;
    return await db.update(
      AlarmInfo.tableName,
      alarm.toMap(),
      where: '${AlarmInfo.columnId} = ?',
      whereArgs: [alarm.id],
    );
  }

  // Delete
  Future<int> delete(int id) async {
    Database db = await _instance.database;
    return await db.delete(
      AlarmInfo.tableName,
      where: '${AlarmInfo.columnId} = ?',
      whereArgs: [id],
    );
  }

  //get number of note obj in database
  Future<int> getCount() async {
    Database db = await _instance.database;
    List<Map> noteCount =
        await db.rawQuery('SELECT COUNT (*) FROM ${AlarmInfo.tableName}');
    int result = Sqflite.firstIntValue(noteCount);
    return result;
  }
}

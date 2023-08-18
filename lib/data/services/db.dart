// import 'dart:convert';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import 'package:weather_service/data/models/weather.dart';

// class DatabaseHelper {
//   static const _databaseName = 'weather.db';
//   static const _databaseVersion = 1;

//   static const tableWeather = 'weather';
//   static const columnId = '_id';
//   static const columnTemperature = 'temperature';
//   static const columnHumidity = 'humidity';
//   static const columnWindSpeed = 'wind_speed';

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }

//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final path = await getDatabasesPath();
//     final databasePath = join(path, _databaseName);

//     return await openDatabase(
//       databasePath,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute(
//       "CREATE TABLE $tableWeather(id INTEGER PRIMARY KEY, data TEXT)",
//     );
//   }

//   Future<int> saveWeatherData(Weather weather) async {
//     final db = await database;
//     final json = jsonEncode(weather.toJson());
//     return db.insert(tableWeather, {'data': json});
//   }

//   Future<Weather> getWeatherData() async {
//     final db = await database;
//     final maps = await db.query(tableWeather);
//     final json = jsonDecode(maps.first['data'] as String);
//     return Weather.fromJson(json);
//   }
// }

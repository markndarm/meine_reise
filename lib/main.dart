import 'package:flutter/material.dart';
import 'package:meine_reise/screens/login_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<Map> usersList = [];
List<Map> traveledToList = [];
List<Map> tripsList = [];
List<Map> stopsList = [];
List<int> myTravelList = [];
List<int> myStopsList = [];
int registeredUser = -1;
int currentTrip = -1;
List splittedPacklist = [];
int addStopIndex = -1;
String? profilePicturePath = "";

List imgList = [

];

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // connect to database
  createDatabase();
  // end of database

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}

createDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'users.db');
  await deleteDatabase(path);
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE Users (id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT, instagram TEXT, profilePicture TEXT, level INTEGER, profilePicturePath TEXT);');
        await db.execute(
            'CREATE TABLE Trips (id INTEGER PRIMARY KEY, name TEXT, profilePicture TEXT, date TEXT, list TEXT, pre TEXT);');
        await db.execute(
            'CREATE TABLE TraveledTo (id INTEGER PRIMARY KEY, U_id INTEGER, T_id INTEGER)');
        await db.execute(
            'CREATE TABLE Stops (id INTEGER PRIMARY KEY, date TEXT, startPosition TEXT, startTime TEXT, startStreet TEXT, meanOfTransport TEXT, endPosition TEXT, endTime TEXT, endStreet TEXT, trip INTEGER)');
  });

// Insert some records in a transaction
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
        'INSERT INTO Users(username, email, password, instagram, profilePicture, level, profilePicturePath) VALUES("mark", "mark", "mark", "mark", "assets/Ägypten.jpg", 3, "")');
    print('inserted1: $id1');
    int id2 = await txn.rawInsert(
        'INSERT INTO Users(username, email, password, instagram, profilePicture, level, profilePicturePath) VALUES(?, ?, ?, ?, ?, ?, ?)',
        ['lars', 'lars', 'lars', 'lars@', "assets/Japan.jpg", 1, ""]);
    print('inserted2: $id2');
    int id3 = await txn.rawInsert(
        'INSERT INTO Trips(name, profilePicture, date, list, pre) VALUES("Ägypten", "assets/Ägypten.jpg", "05.09.2022 - 29.09.2022", "2x Schlüssel@1x Handy@1x Ausweis@5x Wasser@6x Zahnpasta", "y"), ("Thailand", "assets/Thailand.jpg", "05.09.2022 - 29.09.2022", "2x Schlüssel@1x Handy@1x Ausweis@5x Wasser@6x Zahnpasta", "y"), ("Spanien", "assets/Spanien.jpg", "05.09.2022 - 29.09.2022", "2x Schlüssel@1x Handy@1x Ausweis@5x Wasser@6x Zahnpasta", "y"), ("Belgien", "assets/Belgien.jpg", "05.09.2022 - 29.09.2022", "2x Schlüssel@1x Handy@1x Ausweis@5x Wasser@6x Zahnpasta", "y"), ("China", "assets/China.jpg", "05.09.2022 - 29.09.2022", "2x Schlüssel@1x Handy@1x Ausweis@5x Wasser@6x Zahnpasta", "y"), ("Brasilien", "assets/Brasilien.jpg", "05.09.2022 - 29.09.2022", "2x Schlüssel@1x Handy@1x Ausweis@5x Wasser@6x Zahnpasta", "y"), ("Peru", "assets/Peru.jpg", "05.09.2022 - 29.09.2022", "2x Schlüssel@1x Handy@1x Ausweis@5x Wasser@6x Zahnpasta", "y")');
    print('inserted3: $id3');
    int id4 = await txn.rawInsert(
        'INSERT INTO TraveledTo(U_id, T_id) VALUES(1, 1), (1, 2), (1, 3), (1, 4), (2, 5), (2, 6), (2, 7)');
    print('inserted4: $id4');
    int id5 = await txn.rawInsert(
        'INSERT INTO Stops(date, startPosition, startTime, startStreet, meanOfTransport, endPosition, endTime, endStreet, trip) VALUES("22.04.2019", "Kairo", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Luxor", "15:45", "Niemandsstraße 4b", 1), ("22.04.2019", "Luxor", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Komombo", "15:45", "Niemandsstraße 4b", 1), ("22.04.2019", "Komombo", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Alexandria", "15:45", "Niemandsstraße 4b", 1), ("22.04.2019", "Alexandria", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Theben", "15:45", "Niemandsstraße 4b", 1), ("22.04.2019", "Bangkok", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Ayutthaya", "15:45", "Niemandsstraße 4b", 2), ("22.04.2019", "Ayutthaya", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Chiang Mai", "15:45", "Niemandsstraße 4b", 2), ("22.04.2019", "Madrid", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Malaga", "15:45", "Niemandsstraße 4b", 3), ("22.04.2019", "Malaga", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Almunecar", "15:45", "Niemandsstraße 4b", 3), ("22.04.2019", "Almunecar", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Granada", "15:45", "Niemandsstraße 4b", 3), ("22.04.2019", "Granada", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Nerja", "15:45", "Niemandsstraße 4b", 3), ("22.04.2019", "Nerja", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Motril", "15:45", "Niemandsstraße 4b", 3), ("22.04.2019", "Bruessel", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Antwerpen", "15:45", "Niemandsstraße 4b", 4), ("22.04.2019", "Pekin", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Shanghai", "15:45", "Niemandsstraße 4b", 5), ("22.04.2019", "Shanghai", "13:05", "Shanghai 23a", "Bus 3, Steg 4", "Shenzhen", "15:45", "Niemandsstraße 4b", 5), ("22.04.2019", "Shenzhen", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Kumming", "15:45", "Niemandsstraße 4b", 5), ("22.04.2019", "Kumming", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Xian", "15:45", "Niemandsstraße 4b", 5), ("22.04.2019", "Xian", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Chin Stadt", "15:45", "Niemandsstraße 4b", 5), ("22.04.2019", "Sao Paolo", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Rio", "15:45", "Niemandsstraße 4b", 6), ("22.04.2019", "Rio", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Sao Paolo", "15:45", "Niemandsstraße 4b", 6), ("22.04.2019", "Lima", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Lima", "15:45", "Niemandsstraße 4b", 7), ("22.04.2019", "Lima", "13:05", "Breslauerstrasse 23a", "Bus 3, Steg 4", "Lima", "15:45", "Niemandsstraße 4b", 7)');
    print('inserted5: $id5');
  });

  usersList = await database.rawQuery('SELECT * FROM Users');
  traveledToList = await database.rawQuery('SELECT * FROM TraveledTo');
  tripsList = await database.rawQuery('SELECT * FROM Trips');
  stopsList = await database.rawQuery('SELECT * FROM Stops');
  print(stopsList);
}

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meine_reise/screens/add_stop.dart';
import 'package:meine_reise/screens/profile_screen.dart';
import 'package:meine_reise/screens/settings_screen.dart';
import 'package:meine_reise/main.dart';
import 'package:meine_reise/screens/single_trip_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'add_trip.dart';
import 'dashboard_screen.dart';
import 'edit_single_trip_screen.dart';
import 'login_screen.dart';

class EditSingleTripScreen extends StatelessWidget {
  EditSingleTripScreen({Key? key}) : super(key: key);

  @override

  String? tripProfilePicture = "";

  final nameController =
      TextEditingController(text: "${tripsList[currentTrip]['name']}");
  final rangeController =
  TextEditingController(text: "${tripsList[currentTrip]['date']}");
  final listController =
  TextEditingController(text: "${tripsList[currentTrip]['list']}");
  List<TextEditingController> dateController = List.generate(myStopsList.length,
      (i) => TextEditingController(text: '${stopsList[myStopsList[i]]['date']}'));
  List<TextEditingController> startPositionController = List.generate(
      myStopsList.length,
      (i) => TextEditingController(text: '${stopsList[myStopsList[i]]['startPosition']}'));
  List<TextEditingController> startTimeController = List.generate(
      myStopsList.length,
          (i) => TextEditingController(text: '${stopsList[myStopsList[i]]['startTime']}'));
  List<TextEditingController> startStreetController = List.generate(
      myStopsList.length,
          (i) => TextEditingController(text: '${stopsList[myStopsList[i]]['startStreet']}'));
  List<TextEditingController> meanOfTransportController = List.generate(
      myStopsList.length,
          (i) => TextEditingController(text: '${stopsList[myStopsList[i]]['meanOfTransport']}'));
  List<TextEditingController> endPositionController = List.generate(
      myStopsList.length,
          (i) => TextEditingController(text: '${stopsList[myStopsList[i]]['endPosition']}'));
  List<TextEditingController> endTimeController = List.generate(
      myStopsList.length,
          (i) => TextEditingController(text: '${stopsList[myStopsList[i]]['endTime']}'));
  List<TextEditingController> endStreetController = List.generate(
      myStopsList.length,
          (i) => TextEditingController(text: '${stopsList[i]['endStreet']}'));

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("My Reise")),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                // anonyme und asynchrone Funktion
                Navigator.push(
                  context,
                  PageTransition(
                      child: SettingsScreen(),
                      type: PageTransitionType.topToBottom
                  ),
                  //MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.black38),
          unselectedItemColor: Colors.green,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: DashboardScreen(),
                        type: PageTransitionType.topToBottom,
                    ),
                    //MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                icon: Icon(Icons.home, color: Colors.green),
              ),
            ),
            BottomNavigationBarItem(
              label: "Add Trip",
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: AddTrip(),
                        type: PageTransitionType.topToBottom
                    ),
                    //MaterialPageRoute(builder: (context) => AddTrip()),
                  );
                },
                icon: Icon(
                  Icons.add_location_alt,
                  color: Colors.green,
                ),
                color: Colors.green,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: ProfileScreen(),
                        type: PageTransitionType.topToBottom
                    ),
                    //MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                icon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.green,
                ),
                color: Colors.green,
              ),
            )
          ]
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: SingleTripScreen(),
                    type: PageTransitionType.topToBottom
                ),
                //MaterialPageRoute(builder: (context) => SingleTripScreen()),
              );
            },
            child: Icon(Icons.arrow_back),
          ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Editiere',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 8.0, left: 8.0, right: 8.0),
                    child: Container(
                      width: 200,
                      height: 120,
                      child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  color: Colors.green,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 60,
                                  child: CircleAvatar(
                                      radius: 55,
                                      backgroundImage: '${tripsList[currentTrip]['pre']}' == "n"
                                          ? Image.file(File('${tripsList[currentTrip]['profilePicture']}')).image
                                          : AssetImage('${tripsList[currentTrip]['profilePicture']}')

                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  color: Colors.green,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.white,),
                                  onPressed: () async {
                                    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                    tripProfilePicture = await image?.path;
                                    if (tripProfilePicture != null) {
                                      tripProfilePicture =
                                          tripProfilePicture!.substring(1);
                                      // upload to database

                                      var databasesPath = await getDatabasesPath();
                                      String path = join(
                                          databasesPath, 'users.db');
                                      Database database = await openDatabase(
                                          path,
                                          version: 1, onCreate:
                                          (Database db, int version) async {
                                        // When creating the db, create the table
                                      });
                                      int count = await database.rawUpdate(
                                          'UPDATE Trips SET profilePicture = ?, pre = ? WHERE id = ?',
                                          [
                                            '${tripProfilePicture}',
                                            "n",
                                            '${tripsList[currentTrip]['id']}'
                                          ]);
                                      tripsList = await database
                                          .rawQuery('SELECT * FROM Trips');
                                      print(
                                          'updated: SELECT * FROM Users WHERE id = ${registeredUser}');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Veränderungen wurden gespeichert!')));

                                      imgList = [];
                                      for (int i = 0; i < myTravelList.length; i++) {
                                        imgList.add(tripsList[myTravelList[i]]['profilePicture']);
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => EditSingleTripScreen()));
                                    }
                                  },
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Material(
                            // E-Mail input
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  hintText: '${tripsList[currentTrip]['name']}',
                                  //labelText: usersList[findIndex()]['username'],
                                  prefixIcon: Icon(Icons.view_headline,
                                      color: Colors.green),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: nameController,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (tripIsValid(nameController.text)) {
                                  // change registeredUser in Database
                                  var databasesPath = await getDatabasesPath();
                                  String path = join(databasesPath, 'users.db');
                                  Database database = await openDatabase(path,
                                      version: 1, onCreate:
                                          (Database db, int version) async {
                                    // When creating the db, create the table
                                  });
                                  int count = await database.rawUpdate(
                                      'UPDATE Trips SET name = ? WHERE id = ?',
                                      [
                                        '${nameController.text}',
                                        '${tripsList[currentTrip]['id']}'
                                      ]);
                                  tripsList = await database
                                      .rawQuery('SELECT * FROM Trips');
                                  print(
                                      'updated: SELECT * FROM Users WHERE id = ${registeredUser}');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Veränderungen wurden gespeichert!')));
                                }
                                ;
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.only(left: 5, right: 5)),
                              child: Text("SAVE")),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Material(
                            // E-Mail input
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 0),
                                  hintText: '${tripsList[currentTrip]['date']}',
                                  //labelText: usersList[findIndex()]['username'],
                                  prefixIcon: Icon(Icons.view_headline,
                                      color: Colors.green),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                controller: rangeController,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (tripIsValid(rangeController.text)) {
                                  // change registeredUser in Database
                                  var databasesPath = await getDatabasesPath();
                                  String path = join(databasesPath, 'users.db');
                                  Database database = await openDatabase(path,
                                      version: 1, onCreate:
                                          (Database db, int version) async {
                                        // When creating the db, create the table
                                      });
                                  int count = await database.rawUpdate(
                                      'UPDATE Trips SET date = ? WHERE id = ?',
                                      [
                                        '${rangeController.text}',
                                        '${tripsList[currentTrip]['id']}'
                                      ]);
                                  tripsList = await database
                                      .rawQuery('SELECT * FROM Trips');
                                  print(
                                      'updated: SELECT * FROM Users WHERE id = ${registeredUser}');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Veränderungen wurden gespeichert!')));
                                }
                                ;
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.only(left: 5, right: 5)),
                              child: Text("SAVE")),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Stops",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.green,
                          child: IconButton(
                            onPressed: () {
                              addStopIndex = myStopsList.length;
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: AddStop(),
                                    type: PageTransitionType.topToBottom
                                ),
                                //MaterialPageRoute(builder: (context) => AddStop()),
                              );
                            },
                            icon: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 450,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: myStopsList.length,
                        itemBuilder: (context, index) {
                          return einzelnerTransport(context, myStopsList[index],
                              index, dateController, startPositionController, startTimeController, startStreetController, meanOfTransportController, endPositionController, endTimeController, endStreetController);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Meine Packliste",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                        "WARNING: Seperate items by \"@\"!",
                        style: TextStyle(
                          color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                  Text(
                      "The items will be shown as a list!",
                      style: TextStyle(
                        color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600,
                      )
                  ),
                  Text(
                      "Example: \"1x ID-Card@2x Water@9x Shirts\"",
                      style: TextStyle(
                        color: Colors.black, fontSize: 12
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Material(
                      // E-Mail input
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            hintText: '${tripsList[currentTrip]['list']}',
                            //labelText: usersList[findIndex()]['username'],
                            prefixIcon: Icon(Icons.backpack, color: Colors.green),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: listController,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (tripIsValid(nameController.text)) {
                            // change registeredUser in Database
                            var databasesPath = await getDatabasesPath();
                            String path = join(databasesPath, 'users.db');
                            Database database = await openDatabase(path,
                                version: 1, onCreate:
                                    (Database db, int version) async {
                                  // When creating the db, create the table
                                });
                            int count = await database.rawUpdate(
                                'UPDATE Trips SET list = ? WHERE id = ?',
                                [
                                  '${listController.text}',
                                  '${tripsList[currentTrip]['id']}'
                                ]);
                            tripsList = await database
                                .rawQuery('SELECT * FROM Trips');
                            print(
                                'updated: SELECT * FROM Users WHERE id = ${registeredUser}');
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Changes were saved!')));
                          }
                          splittedPacklist = tripsList[currentTrip]['list'].split('@');
                          ;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.only(left: 5, right: 5)),
                        child: Text("SAVE LIST")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Current Packlist:",
                      style: TextStyle(
                        color: Colors.green, fontSize: 15, fontWeight: FontWeight.w600,
                      )
                    ),
                  ),
                  Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: splittedPacklist.length,
                      itemBuilder: (context, index) {
                        return einzelnerPackeintrag(
                            context, index, '${splittedPacklist[index]}');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          var databasesPath = await getDatabasesPath();
                          String path = join(databasesPath, 'users.db');
                          Database database = await openDatabase(path, version: 1,
                              onCreate: (Database db, int version) async {
                                // When creating the db, create the table
                              });
                          // delete Stop
                          int count = await database
                              .rawDelete('DELETE FROM Trips WHERE id = ?', ['${tripsList[currentTrip]['id']}']);
                          assert(count == 1);
                          tripsList =
                          await database.rawQuery('SELECT * FROM Trips');
                          print(
                              'updated: SELECT * FROM Users WHERE id = ${registeredUser}');
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text('Trip deleted!')));
                          myStopsList = [];
                          splittedPacklist = [];
                          //PASST print(stopsList[0]['trip']); 1 - 7
                          //PASST print(tripsList[tripsListIndex]['id']); 1 - 4
                          myTravelList = [];
                          for (int i = 0; i < traveledToList.length; i++) {
                            if (traveledToList[i]['U_id'] == registeredUser) {
                              //myTravelList.add(traveledToList[i]['T_id']);
                              for (int j = 0; j < tripsList.length; j++) {
                                if (traveledToList[i]['T_id'] == tripsList[j]['id']) {
                                  myTravelList.add(j);
                                  break;
                                }
                              }
                            }
                          }
                          imgList = [];
                          for (int i = 0; i < myTravelList.length; i++) {
                            imgList.add(tripsList[myTravelList[i]]['profilePicture']);
                          }

                          Navigator.push(
                            context,
                            PageTransition(
                                child: DashboardScreen(),
                                type: PageTransitionType.topToBottom
                            ),
                            //MaterialPageRoute(builder: (context) => DashboardScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          "DELETE TRIP",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  tripIsValid(String s1) {
    if (s1.length > 0) {
      return true;
    }
    return false;
  }

  findIndex() {
    for (int i = 0; i < usersList.length; i++) {
      if (usersList[i]['id'] == registeredUser) {
        return i;
      }
    }
    return 0;
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}

Widget einzelnerTransport(
    context, myStopsListIndex, index, dateController, startPositionController, startTimeController, startStreetController, meanOfTransportController, endPositionController, endTimeController, endStreetController) {
  return Column(
    children: [
      Divider(
        height: 30,
        thickness: 3,
        color: Colors.green,
        indent: 20,
        endIndent: 20,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "${index + 1}", style: TextStyle(
                color: Colors.green, fontSize: 15, fontWeight: FontWeight.w600,
              )
              ),
              Text(
                "dd.mm.yyyy",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Material(
                  // E-Mail input
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        hintText: 'dd-mm-yyyy',
                        //labelText: usersList[findIndex()]['username'],
                        prefixIcon: Icon(Icons.date_range, color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: dateController[index],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Material(
                      // E-Mail input
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            hintText:
                                'Start Position',
                            //labelText: usersList[findIndex()]['username'],
                            prefixIcon: Icon(Icons.place, color: Colors.green),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: startPositionController[index],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Material(
                      // E-Mail input
                      child: SizedBox(
                        width: 115,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            hintText:
                            'Start Time',
                            //labelText: usersList[findIndex()]['username'],
                            prefixIcon: Icon(Icons.timer, color: Colors.green),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          controller: startTimeController[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Material(
                  // E-Mail input
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        hintText:
                        'Start Street',
                        //labelText: usersList[findIndex()]['username'],
                        prefixIcon: Icon(Icons.add_road, color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: startStreetController[index],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Material(
                  // E-Mail input
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        hintText:
                        'Mean Of Transport',
                        //labelText: usersList[findIndex()]['username'],
                        prefixIcon: Icon(Icons.route, color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: meanOfTransportController[index],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Material(
                      // E-Mail input
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            hintText:
                            'End Position',
                            //labelText: usersList[findIndex()]['username'],
                            prefixIcon: Icon(Icons.place, color: Colors.green),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: endPositionController[index],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Material(
                      // E-Mail input
                      child: SizedBox(
                        width: 115,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            hintText:
                            'End Time',
                            //labelText: usersList[findIndex()]['username'],
                            prefixIcon: Icon(Icons.timer, color: Colors.green),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          controller: endTimeController[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Material(
                  // E-Mail input
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        hintText:
                        'End Street',
                        //labelText: usersList[findIndex()]['username'],
                        prefixIcon: Icon(Icons.add_road, color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: endStreetController[index],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Colors.red,
                      onPressed: () async {
                        var databasesPath = await getDatabasesPath();
                        String path = join(databasesPath, 'users.db');
                        Database database = await openDatabase(path, version: 1,
                            onCreate: (Database db, int version) async {
                              // When creating the db, create the table
                            });
                        // delete Stop
                        int count = await database
                            .rawDelete('DELETE FROM Stops WHERE id = ?', ['${stopsList[myStopsList[index]]['id']}']);
                        assert(count == 1);
                        stopsList =
                        await database.rawQuery('SELECT * FROM Stops');
                        print(
                            'updated: SELECT * FROM Users WHERE id = ${registeredUser}');
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                Text('Veränderungen wurden gespeichert!')));
                        myStopsList = [];
                        splittedPacklist = [];
                        //PASST print(stopsList[0]['trip']); 1 - 7
                        //PASST print(tripsList[tripsListIndex]['id']); 1 - 4

                        for (int i = 0; i < stopsList.length; i++) {
                          if (stopsList[i]['trip'] == tripsList[currentTrip]['id']) {
                            //PASST print(stopsList[i]['trip']);
                            myStopsList.add(i);
                          }
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditSingleTripScreen()),
                        );
                      },
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (dateController[index].text.length > 0 && startPositionController[index].text.length > 0 && startTimeController[index].text.length > 0 && meanOfTransportController[index].text.length > 0 && endPositionController[index].text.length > 0 && endTimeController[index].text.length > 0 && endStreetController[index].text.length > 0) {
                            // change registeredUser in Database
                            var databasesPath = await getDatabasesPath();
                            String path = join(databasesPath, 'users.db');
                            Database database = await openDatabase(path, version: 1,
                                onCreate: (Database db, int version) async {
                              // When creating the db, create the table
                            });
                            int count = await database.rawUpdate(
                                'UPDATE Stops SET date = ?, startPosition = ?, startTime = ?, startStreet = ?, meanOfTransport = ?, endPosition = ?, endTime = ?, endStreet = ? WHERE id = ?', [
                              '${dateController[index].text}',
                              '${startPositionController[index].text}',
                              '${startTimeController[index].text}',
                              '${startStreetController[index].text}',
                              '${meanOfTransportController[index].text}',
                              '${endPositionController[index].text}',
                              '${endTimeController[index].text}',
                              '${endStreetController[index].text}',
                              '${stopsList[myStopsList[index]]['id']}'
                            ]);
                            stopsList =
                                await database.rawQuery('SELECT * FROM Stops');
                            print(
                                'updated: SELECT * FROM Users WHERE id = ${registeredUser}');
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Changes were saved!')));
                          }
                          ;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.only(left: 20, right: 20)),
                        child: Text("SAVE STOP ${index + 1}")),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget einzelnerPackeintrag(context, index, item) {
  return Container(
    width: double.infinity,
    child: Row(
      children: [
        Text("${index + 1}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.green,
              fontWeight: FontWeight.w800,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text("${item}", style: TextStyle(fontSize: 15)),
        ),
      ],
    ),
  );
}

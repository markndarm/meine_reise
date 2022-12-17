import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:meine_reise/screens/profile_screen.dart';
import 'package:meine_reise/screens/settings_screen.dart';
import 'package:meine_reise/main.dart';
import 'package:meine_reise/screens/single_trip_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'dashboard_screen.dart';
import 'edit_single_trip_screen.dart';
import 'login_screen.dart';

class AddTrip extends StatefulWidget {
  AddTrip({Key? key}) : super(key: key);

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  String? tripProfilePicture = "";

  @override

  final nameController = TextEditingController();

  final rangeController = TextEditingController();

  final dateController = TextEditingController();

  final startPositionController = TextEditingController();

  final startTimeController = TextEditingController();

  final startStreetController = TextEditingController();

  final meanOfTransportController = TextEditingController();

  final endPositionController = TextEditingController();

  final endTimeController = TextEditingController();

  final endStreetController = TextEditingController();

  final listController = TextEditingController();

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
                          type: PageTransitionType.leftToRight
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
                      MaterialPageRoute(builder: (context) => AddTrip()),
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
                          type: PageTransitionType.rightToLeft
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
                  type: PageTransitionType.leftToRight
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
                      'Add Trip',
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
                                      backgroundImage: tripProfilePicture == null || tripProfilePicture?.length == 0
                                          ? AssetImage('assets/thisFileDoesNotExist.jpg')
                                          : Image.file(File(tripProfilePicture!)).image

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
                                      int findIndexResult = findIndex();
                                      tripProfilePicture = tripProfilePicture!.substring(1);
                                      // upload to database
                                    }
                                  },
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Material(
                        // E-Mail input
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 0),
                              hintText: 'Country',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Material(
                        // E-Mail input
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 0),
                              hintText: 'dd/mm/yyyy - dd/mm/yyyy',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "New Stop",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  einzelnerTransport(context, addStopIndex, dateController, startPositionController, startTimeController, startStreetController, meanOfTransportController, endPositionController, endTimeController, endStreetController),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "My Packlist",
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
                            hintText: 'My packlist for this trip',
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
                          if (nameController.text.length > 0 && rangeController.text.length > 0 && dateController.text.length > 0 && startPositionController.text.length > 0 && startTimeController.text.length > 0 && meanOfTransportController.text.length > 0 && endPositionController.text.length > 0 && endTimeController.text.length > 0 && endStreetController.text.length > 0 && listController.text.length > 0) {
                            if (tripProfilePicture == null || tripProfilePicture!.length == 0) {
                              tripProfilePicture = "assets/default-scenery.jpg";
                            }
                            // add trip
                            var databasesPath = await getDatabasesPath();
                            String path = join(databasesPath, 'users.db');
                            Database database = await openDatabase(path, version: 1,
                                onCreate: (Database db, int version) async {
                                  // When creating the db, create the table
                                });
                            int id3 = -1;

                            // insert trip into Trips
                            await database.transaction((txn) async {
                              id3 = await txn.rawInsert(
                                  'INSERT INTO Trips(name, profilePicture, date, list, pre) VALUES("${nameController.text}", "${tripProfilePicture}", "${rangeController.text}", "${listController.text}", "n")');
                            });
                            tripsList =
                            await database.rawQuery('SELECT * FROM Trips');
                            print("Sheeesh ${tripsList}");

                            // insert stop into Stops
                            await database.transaction((txn) async {
                              int id5 = await txn.rawInsert(
                                  'INSERT INTO Stops(date, startPosition, startTime, startStreet, meanOfTransport, endPosition, endTime, endStreet, trip) VALUES("${dateController.text}", "${startPositionController.text}", "${startTimeController.text}", "${startStreetController.text}", "${meanOfTransportController.text}", "${endPositionController.text}", "${endTimeController.text}", "${endStreetController.text}", ${id3})');
                              print('inserted5: $id5');
                            });
                            stopsList =
                            await database.rawQuery('SELECT * FROM Stops');
                            // insert intro TraveledTo
                            await database.transaction((txn) async {
                              int id4 = await txn.rawInsert(
                                  'INSERT INTO TraveledTo(U_id, T_id) VALUES(${registeredUser}, ${id3})');
                            });
                            traveledToList = await database.rawQuery('SELECT * FROM TraveledTo');

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
                                  type: PageTransitionType.leftToRight
                              ),
                              //MaterialPageRoute(builder: (context) => DashboardScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.only(left: 5, right: 5)),
                        child: Text("SAVE TRIP")),
                  ),
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
}

Widget einzelnerTransport(
    context, myStopsListIndex, dateController, startPositionController, startTimeController, startStreetController, meanOfTransportController, endPositionController, endTimeController, endStreetController) {
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
                  "1", style: TextStyle(
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
                      controller: dateController,
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
                          controller: startPositionController,
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
                          controller: startTimeController,
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
                        'Start Screen',
                        //labelText: usersList[findIndex()]['username'],
                        prefixIcon: Icon(Icons.add_road, color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: startStreetController,
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
                        'Mean of Transport',
                        //labelText: usersList[findIndex()]['username'],
                        prefixIcon: Icon(Icons.route, color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: meanOfTransportController,
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
                          controller: endPositionController,
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
                          controller: endTimeController,
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
                      controller: endStreetController,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:meine_reise/screens/add_trip.dart';
import 'package:meine_reise/screens/profile_screen.dart';
import 'package:meine_reise/screens/settings_screen.dart';
import 'package:meine_reise/main.dart';
import 'package:meine_reise/screens/single_trip_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dashboard_screen.dart';
import 'edit_single_trip_screen.dart';
import 'login_screen.dart';

class AddStop extends StatelessWidget {
  AddStop({Key? key}) : super(key: key);

  @override

  final dateController = TextEditingController();
  final startPositionController = TextEditingController();
  final startTimeController = TextEditingController();
  final startStreetController = TextEditingController();
  final meanOfTransportController = TextEditingController();
  final endPositionController = TextEditingController();
  final endTimeController = TextEditingController();
  final endStreetController = TextEditingController();


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
                          type: PageTransitionType.topToBottom
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
                      'Add Stop',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
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
                  "${addStopIndex + 1}", style: TextStyle(
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
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: ElevatedButton(
                    onPressed: () async {

                      if (dateController.text.length > 0 && startPositionController.text.length > 0 && startTimeController.text.length > 0 && meanOfTransportController.text.length > 0 && endPositionController.text.length > 0 && endTimeController.text.length > 0 && endStreetController.text.length > 0) {
                        // change registeredUser in Database
                        var databasesPath = await getDatabasesPath();
                        String path = join(databasesPath, 'users.db');
                        Database database = await openDatabase(path, version: 1,
                            onCreate: (Database db, int version) async {
                              // When creating the db, create the table
                            });
                        await database.transaction((txn) async {
                          int id5 = await txn.rawInsert(
                              'INSERT INTO Stops(date, startPosition, startTime, startStreet, meanOfTransport, endPosition, endTime, endStreet, trip) VALUES("${dateController.text}", "${startPositionController.text}", "${startTimeController.text}", "${startStreetController.text}", "${meanOfTransportController.text}", "${endPositionController.text}", "${endTimeController.text}", "${endStreetController.text}", ${tripsList[currentTrip]['id']})');
                          print('inserted5: $id5');
                        });
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
                      }
                      ;


                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.only(left: 20, right: 20)),
                    child: Text("SAVE STOP ${addStopIndex + 1}")),
              )
            ],
          ),
        ),
      )
    ],
  );
}

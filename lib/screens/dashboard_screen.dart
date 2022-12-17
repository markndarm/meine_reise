import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meine_reise/main.dart';
import 'package:meine_reise/screens/login_screen.dart';
import 'package:meine_reise/screens/profile_screen.dart';
import 'package:meine_reise/screens/settings_screen.dart';
import 'package:meine_reise/screens/single_trip_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'add_trip.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("My Reise")),
            actions: <Widget>[
              IconButton(
                onPressed: () async { // anonyme und asynchrone Funktion
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
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
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
                        type: PageTransitionType.rightToLeft,
                    ),
                    //MaterialPageRoute(builder: (context) => AddTrip()),
                  );
                },
                icon: Icon(Icons.add_location_alt, color: Colors.green,),
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
                icon: Icon(Icons.account_circle_rounded, color: Colors.green,),
                color: Colors.green,
              ),
            )          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0, top: 15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0, top: 22.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 300,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container( // Circle of Progressbar
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)) ,
                          color: Colors.green,
                        ),
                        width: 80,
                        height: 80,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 0.0),
                                child: Text("Lvl", style: TextStyle( // Lvl of Progressbar
                                  fontSize: 15,
                                  color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Text("${usersList[findIndex()]['level']}", style: TextStyle( // 2 of Progressbar
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                )),
                              )
                            ],
                          ),
                        )
                    )
                  ],
                ),
                Container( // "Meine Reisen"
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 8.0, top: 30.0, bottom: 10.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "My Trips",
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
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                              child: AddTrip(),
                                              type: PageTransitionType.rightToLeft,
                                          ),
                                          //MaterialPageRoute(builder: (context) => AddTrip()),
                                        );
                                      },
                                      icon: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      myTravelList.length <= 0
                      ? Text("No Trips yet")
                      : Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container( // List of all own trips
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)) ,

                            ),
                          //color: Colors.green,
                          width: double.infinity,
                          height: 250,
                          child: Scrollbar(
                            interactive: false,
                            thumbVisibility: true,
                            child: ListView.builder(
                              itemCount: myTravelList.length,
                              itemBuilder: (context, index) {
                                return meineReiseEintrag(context, myTravelList[index], "${tripsList[myTravelList[index]]['name']}", "${tripsList[myTravelList[index]]['date']}", "${tripsList[myTravelList[index]]['profilePicture']}", "${tripsList[myTravelList[index]]['pre']}");
                              },
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                  thickness: 3,
                  color: Colors.green,
                  indent: 20,
                  endIndent: 20,
                ),
                Container( // "Andere Reisen"
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 8.0, top: 30.0, bottom: 10.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Other Trips",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container( // List of all own trips
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)) ,

                            ),
                            //color: Colors.green,
                            width: double.infinity,
                            height: 250,
                            child: Scrollbar(
                              interactive: false,
                              thumbVisibility: true,
                              child: ListView(
                                children: [
                                  meineReiseEintrag(context, -1, "Thailand 2022", "05.09.2022 - 29.09.2022", "assets/Japan.jpg", "y"),
                                  meineReiseEintrag(context, -1, "Japan 2019", "03.07.2019 - 27.07.2019", "assets/Rom.jpg", "y"),
                                  meineReiseEintrag(context, -1, "Sizilien 2022", "03.07.2019 - 27.07.2019", "assets/Ägypten.jpg", "y"),
                                  meineReiseEintrag(context, -1, "Paris 2021", "03.07.2019 - 27.07.2019", "assets/SuedAfrika.jpg", "y"),
                                  meineReiseEintrag(context, -1, "London 2020", "03.07.2019 - 27.07.2019", "assets/Japan.jpg", "y"),
                                  meineReiseEintrag(context, -1, "Rom 2019", "03.07.2019 - 27.07.2019", "assets/Japan.jpg", "y"),
                                ],
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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

Widget meineReiseEintrag(context, tripsListIndex, tripTitle, tripDates, imageUrl, pre) {
  return InkWell(
    onTap: () async { // anonyme und asynchrone Funktion
      // Show specific Route
      myStopsList = [];
      splittedPacklist = [];
      //PASST print(stopsList[0]['trip']); 1 - 7
      //PASST print(tripsList[tripsListIndex]['id']); 1 - 4

      for (int i = 0; i < stopsList.length; i++) {
        if (stopsList[i]['trip'] == tripsList[tripsListIndex]['id']) {
          //PASST print(stopsList[i]['trip']);
          myStopsList.add(i);
        }
      }
      currentTrip = tripsListIndex;
      // Get Package List
      splittedPacklist = tripsList[currentTrip]['list'].split('@');
      Navigator.push(
        context,
        PageTransition(
            child: SingleTripScreen(),
            type: PageTransitionType.rightToLeft,
        ),
        //MaterialPageRoute(builder: (context) => SingleTripScreen()),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 27.0, top: 0.0),
            child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 0, right: 0, bottom: 0),
                      child: Column(
                        children: [
                          Text(
                            tripTitle,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            tripDates,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            child: Icon(Icons.arrow_circle_right_rounded, color: Colors.white, size: 40,),
                            onPressed: () async { // anonyme und asynchrone Funktion
                              // Show specific Route
                              myStopsList = [];
                              splittedPacklist = [];
                              //PASST print(stopsList[0]['trip']); 1 - 7
                              //PASST print(tripsList[tripsListIndex]['id']); 1 - 4

                              for (int i = 0; i < stopsList.length; i++) {
                                if (stopsList[i]['trip'] == tripsList[tripsListIndex]['id']) {
                                  //PASST print(stopsList[i]['trip']);
                                  myStopsList.add(i);
                                }
                              }
                              currentTrip = tripsListIndex;
                              // Get Package List
                              splittedPacklist = tripsList[currentTrip]['list'].split('@');
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: SingleTripScreen(),
                                    type: PageTransitionType.rightToLeft,
                                ),
                                //MaterialPageRoute(builder: (context) => SingleTripScreen()),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 30,
            child: CircleAvatar(
              radius: 28,
              backgroundImage: pre == "n"
                ? Image.file(File(imageUrl)).image
                  : AssetImage(imageUrl)
            ),
          ),
        ],
      ),
    ),
  );
}
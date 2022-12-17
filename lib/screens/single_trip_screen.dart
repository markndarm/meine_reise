import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:meine_reise/screens/profile_screen.dart';
import 'package:meine_reise/screens/settings_screen.dart';
import 'package:meine_reise/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'add_trip.dart';
import 'dashboard_screen.dart';
import 'edit_single_trip_screen.dart';
import 'login_screen.dart';
import 'dart:io';

bool? checkmark = false;


class SingleTripScreen extends StatefulWidget {
  const SingleTripScreen({Key? key}) : super(key: key);

  @override
  State<SingleTripScreen> createState() => _SingleTripScreenState();
}

class _SingleTripScreenState extends State<SingleTripScreen> {
  int activeIndex = 0;
  @override
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
                    PageTransition(
                        child: AddTrip(),
                        type: PageTransitionType.rightToLeft
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
          ],
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: EditSingleTripScreen(),
                    type: PageTransitionType.bottomToTop
                ),
                //MaterialPageRoute(builder: (context) => EditSingleTripScreen()),
              );
            },
            child: Icon(Icons.edit),
          ),
        body: Scrollbar(
          thickness: 7,
          trackVisibility: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${tripsList[currentTrip]['name']}',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${tripsList[currentTrip]['date']}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 150,
                                    child: tripsList[currentTrip]['pre'] == "y" || tripsList[currentTrip]['profilePicture'] == "assets/default-scenery.jpg"
                                        ? Image.asset('${tripsList[currentTrip]['profilePicture']}', fit: BoxFit.cover,)
                                        : Image.file(File('${tripsList[currentTrip]['profilePicture']}',)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: Colors.green,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 50,
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundImage: usersList[findIndex()]['profilePicturePath'] == null || usersList[findIndex()]['profilePicturePath'].length == 0
                                        ? AssetImage('${usersList[findIndex()]['profilePicture']}')
                                        : Image.file(File(usersList[findIndex()]['profilePicturePath'])).image
                                    ,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Meine Stops",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: myStopsList.length,
                          itemBuilder: (context, index) {
                            return einzelnerTransport(
                                context, index, myStopsList[index]);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "My Packlist",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: splittedPacklist.length,
                        itemBuilder: (context, index) {
                          return einzelnerPackeintrag(context, index, '${splittedPacklist[index]}');
                        },
                      ),
                    ),
                  ],
                ),
              ),
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

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}

Widget einzelnerTransport(context, index, myStopsListIndex) {
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
              Text(
                stopsList[myStopsListIndex]['date'],
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                children: [
                  Container(
                      child: Icon(
                    Icons.place,
                    color: Colors.green,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stopsList[myStopsListIndex]['startPosition'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          width: 270,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(stopsList[myStopsListIndex]['startTime'] + "Uhr",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                              Text(
                                stopsList[myStopsListIndex]['startStreet'],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15),
                child: Row(
                  children: [
                    Icon(Icons.route, color: Colors.green),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(stopsList[myStopsListIndex]['meanOfTransport']),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                      child: Icon(
                    Icons.place,
                    color: Colors.green,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stopsList[myStopsListIndex]['endPosition'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          width: 270,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(stopsList[myStopsListIndex]['endTime'],
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                              Text(
                                stopsList[myStopsListIndex]['endStreet'],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
        Text("${index + 1}", style: TextStyle(
          fontSize: 15,
          color: Colors.green,
          fontWeight: FontWeight.w800,
        )),
        MyStatefulWidget(),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text("${item}", style: TextStyle(fontSize: 15)),
        ),
      ],
    ),
  );
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.green;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

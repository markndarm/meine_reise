import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/services.dart';
import 'package:meine_reise/main.dart';
import 'package:meine_reise/screens/add_trip.dart';
import 'package:meine_reise/screens/single_trip_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:meine_reise/screens/edit_profile_screen.dart';
import 'package:meine_reise/screens/settings_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'dart:io';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                        type: PageTransitionType.leftToRight,
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
                        type: PageTransitionType.leftToRight
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                icon: Icon(Icons.account_circle_rounded, color: Colors.green,),
                color: Colors.green,
              ),
            )          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  child: EditProfileScreen(),
                  type: PageTransitionType.bottomToTop
              ),
              //MaterialPageRoute(builder: (context) => EditProfileScreen()),
            );
          },
          child: Icon(Icons.edit),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0, bottom: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    width: 230,
                    height: 160,
                    child: Stack(
                        children: [
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            color: Colors.green,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 75,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: usersList[findIndex()]['profilePicturePath'] == null || usersList[findIndex()]['profilePicturePath'].length == 0
                                  ? AssetImage('${usersList[findIndex()]['profilePicture']}')
                                  : Image.file(File(usersList[findIndex()]['profilePicturePath'])).image
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              color: Colors.green,
                            ),
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
                          ,
                        ),
                      )
                    ]),
                  ),
                ),
                Text(
                    usersList[findIndex()]['username'].toUpperCase(),
                  style: TextStyle(
                    fontSize: 30,
                  )
                ),
                Center(
                  child: Container(
                    width: 330,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Instagram",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  if (usersList[findIndex()]['instagram'].length > 0) {
                                    if (!await launchUrl(
                                      Uri(scheme: 'https', host: 'www.instagram.com', path: '${usersList[findIndex()]['instagram']}/'),
                                      mode: LaunchMode.inAppWebView,
                                    )) {
                                      throw 'Could not launch this url';
                                    }
                                  }
                                },
                                icon: Icon(Icons.arrow_circle_right_rounded, color: Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "E-Mail",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(text: "${usersList[findIndex()]['email']}"));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Copied Email-Address!')));
                              },
                              icon: Icon(Icons.copy, color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 30,
                  thickness: 3,
                  color: Colors.green,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  "My Trips",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: imgList.length <= 0
                  ? Text("No Trips Yet")
                  : Container(
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: imgList.length,
                            options: CarouselOptions(
                              height: 175,
                              autoPlay: false,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              initialPage: 0,
                              onPageChanged: (index, reason) => setState(() => activeIndex = index),
                            ),
                            itemBuilder: (context, index, realIndex) {
                              final img = imgList[index];

                              return buildImage(img, index);
                            },
                          ),
                          const SizedBox(height: 32),
                          buildIndicator(),
                        ],
                      ),
                  ),
                ),
                Divider(
                  height: 30,
                  thickness: 3,
                  color: Colors.green,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: LoginScreen(),
                              type: PageTransitionType.leftToRight,
                          ),
                          //MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('You logged out!')));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        "LOG OUT",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  findIndex() {
    for (int i = 0; i < usersList.length; i++) {
      if (usersList[i]['id'] == registeredUser) {
        return i;
      }
      //print("###################################### ${i}");
    }
    return 0;
  }

  Widget buildImage(String img, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 0),
    child: InkWell(
      onTap: () async {
        int tripsListIndex = myTravelList[index];
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
              type: PageTransitionType.leftToRight
          ),
          //MaterialPageRoute(builder: (context) => SingleTripScreen()),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.green,
            child: Stack(
              children: [
                tripsList[myTravelList[index]]['pre'] == "y" || tripsList[myTravelList[index]]['profilePicture'] == "assets/default-scenery.jpg"
                ? Image.asset('${img}', fit: BoxFit.cover,)
                : Image.file(File(img,)),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Row(
                    children: [
                      Text(
                        "${tripsList[myTravelList[index]]['name']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.arrow_circle_right, color: Colors.white, size: 32
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    ),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: imgList.length,
    effect: SwapEffect(
      dotColor: Colors.black38,
      activeDotColor: Colors.green,
      dotHeight: 10,
      dotWidth: 10,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meine_reise/main.dart';
import 'package:meine_reise/screens/profile_screen.dart';
import 'package:meine_reise/screens/settings_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'add_trip.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();


}

class _EditProfileScreenState extends State<EditProfileScreen> {



  Future pickImage(context) async {
    print("1 ${profilePicturePath}");
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    profilePicturePath = await image?.path;
    if (profilePicturePath != null) {
      int findIndexResult = findIndex();
      profilePicturePath = profilePicturePath!.substring(1);
      // upload to database
      print("stop");
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'users.db');
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
          });
      int count = await database.rawUpdate(
          'UPDATE Users SET profilePicturePath = ? WHERE id = ?',
          ['${profilePicturePath}', '${registeredUser}']);
      usersList = await database.rawQuery('SELECT * FROM Users');
      print('updated: SELECT * FROM Users WHERE id = ${registeredUser}');
      print("Shesh ${usersList[findIndex()]['profilePicturePath']}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditProfileScreen()),
      );
    }

  }

  @override

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final instagramController = TextEditingController();

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
                    PageTransition(
                        child: ProfileScreen(),
                        type: PageTransitionType.topToBottom
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
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Profilepicture will save on change",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 8.0, left: 8.0, right: 8.0),
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
                                child: IconButton(
                                    icon: Icon(Icons.edit, color: Colors.white,),
                                    onPressed: () {
                                      pickImage(context);
                                    },
                                  ),
                                ),
                              ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Material( // E-Mail input
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            hintText: 'enter Username',
                            //labelText: usersList[findIndex()]['username'],
                            prefixIcon: Icon(Icons.person, color: Colors.green),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: usernameController,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30.0, left: 43),
                        child: Material( // E-Mail input
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0),
                                hintText: 'enter E-Mail Address',
                                //labelText: "@Email",
                                prefixIcon: Icon(Icons.mail, color: Colors.green),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              controller: emailController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30.0, left: 43),
                        child: Material( // E-Mail input
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0),
                                hintText: 'enter Instagram',
                                //labelText: "@Instagram",
                                prefixIcon: Icon(Icons.camera_alt, color: Colors.green),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: instagramController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                        onPressed: () async{
                          if (changeIsValid(usernameController.text, emailController.text, instagramController.text)) {
                            // change registeredUser in Database
                            var databasesPath = await getDatabasesPath();
                            String path = join(databasesPath, 'users.db');
                            Database database = await openDatabase(path, version: 1,
                                onCreate: (Database db, int version) async {
                                  // When creating the db, create the table
                                });
                            int count = await database.rawUpdate(
                                'UPDATE Users SET username = ?, email = ?, instagram = ? WHERE id = ?',
                                ['${usernameController.text}', '${emailController.text}', '${instagramController.text}', '${registeredUser}']);
                            usersList = await database.rawQuery('SELECT * FROM Users');
                            print('updated: SELECT * FROM Users WHERE id = ${registeredUser}');


                            Navigator.push(
                              context,
                              PageTransition(
                                  child: ProfileScreen(),
                                  type: PageTransitionType.topToBottom
                              ),
                              //MaterialPageRoute(builder: (context) => ProfileScreen()),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'Profile was updated!')));
                          };
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.only(left: 50, right: 50)
                        ),
                        child: Text(
                            "SAVE"
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          // delete Account
                          var databasesPath = await getDatabasesPath();
                          String path = join(databasesPath, 'users.db');
                          Database database = await openDatabase(path, version: 1,
                              onCreate: (Database db, int version) async {
                                // When creating the db, create the table
                              });
                          // delete user
                          int count = await database
                              .rawDelete('DELETE FROM Users WHERE id = ?', ['${registeredUser}']);
                          usersList = await database.rawQuery('SELECT * FROM Users');
                          // delete trip
                          count = await database
                              .rawDelete('DELETE FROM TraveledTo WHERE U_id = ?', ['${registeredUser}']);
                          traveledToList = await database.rawQuery('SELECT * FROM TraveledTo');
                          Navigator.push(
                            context,
                            PageTransition(
                                child: LoginScreen(),
                                type: PageTransitionType.leftToRight
                            ),
                            //MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Account deleted!')));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          "DELETE ACCOUNT",
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
      ),
    );
  }

  changeIsValid(s1, s2, s3) {
    if (s1.length == 0 || s2.length == 0) {
      return false;
    }
    return true;
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

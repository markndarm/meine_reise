import 'package:flutter/material.dart';
import 'package:meine_reise/main.dart';
import 'package:meine_reise/screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({Key? key}) : super(key: key);


  @override

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final instagramController = TextEditingController();


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Container( // Image Icon
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)) ,
                      color: Colors.green,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text("MyReise", style:
                  TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  ),
                ),
                Text(
                    "CREATE A USER"
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Material( // E-Mail input
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          hintText: 'MustaaMax',
                          labelText: "Username",
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
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Material( // E-Mail input
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          hintText: 'max-mustermann@muster.com',
                          labelText: "Email",
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
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Material( // E-Mail input
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          hintText: '***',
                          labelText: "Password",
                          //errorText: "Incorrect Password",
                          prefixIcon: Icon(Icons.password, color: Colors.green),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: passwordController,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Material( // E-Mail input
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          hintText: 'insta.name',
                          labelText: "Instagram",
                          //errorText: "Incorrect Password",
                          prefixIcon: Icon(Icons.camera_alt, color: Colors.green),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: instagramController,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton( // Register Button
                    onPressed: () async { // anonyme und asynchrone Funktion
                      if (checkRequiredFields(usernameController.text, emailController.text, passwordController.text)) {
                        // create user
                        // connect to database
                        var databasesPath = await getDatabasesPath();
                        String path = join(databasesPath, 'users.db');
                        Database database = await openDatabase(path, version: 1,
                            onCreate: (Database db, int version) async {
                              // When creating the db, create the table
                            });
                        // insert values
                        await database.transaction((txn) async {
                          int id1 = await txn.rawInsert(
                              'INSERT INTO Users(username, email, password, instagram, profilePicture, level) VALUES("${usernameController.text}", "${emailController.text}", "${passwordController.text}", "${instagramController.text}", "assets/default-avatar.jpg", 0)');
                          print('inserted1: $id1');
                        });
                        // update List
                        usersList = await database.rawQuery('SELECT * FROM Users');

                        // Correct input
                        Navigator.push(
                          context,
                          PageTransition(
                              child: LoginScreen(),
                              type: PageTransitionType.topToBottom
                          ),
                          //MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Text("SIGN UP", style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      "You already have an account? Log in here!"
                  ),
                ),
                ElevatedButton( // Login Button
                  onPressed: () async { // anonyme und asynchrone Funktion
                    Navigator.push(
                      context,
                      PageTransition(
                          child: LoginScreen(),
                          type: PageTransitionType.topToBottom
                      ),
                      //MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                    child: Text("LOG IN", style: TextStyle(fontSize: 15),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkRequiredFields(String s1, String s2, String s3) {
    if (s1.length == 0 || s2.length == 0 || s3.length == 0) {
      return false;
    }
    return true;
  }
}





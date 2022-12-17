import 'package:flutter/material.dart';
import 'package:meine_reise/main.dart';
import 'package:meine_reise/screens/dashboard_screen.dart';
import 'package:meine_reise/screens/create_account.dart';
import 'package:page_transition/page_transition.dart';


bool? rememberLogin = false;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Container( // Image Icon
                    width: 130,
                    height: 130,
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
                      fontSize: 30,
                      color: Colors.black,
                    ),
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
                Container(// Checkbox with "remember" text
                  //width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left:40.0, right:30.0),
                    child: CheckboxListTile(
                      title: Text("Remember login"),
                      value: rememberLogin,
                      onChanged: (newBool) {
                        rememberLogin = newBool;
                      },
                    ),
                  ),
                ),
                ElevatedButton( // Login Button
                  onPressed: () { // anonyme und asynchrone Funktion
                    int foundUser = checkUser(emailController.text, passwordController.text);
                    myTravelList = [];
                    if (foundUser != -1) {
                      registeredUser = foundUser;
                      // Register all saved trips
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
                      profilePicturePath = "";

                      imgList = [];
                      for (int i = 0; i < myTravelList.length; i++) {
                        imgList.add(tripsList[myTravelList[i]]['profilePicture']);
                      }

                      // correct Logindata
                      Navigator.push(
                        context,
                        PageTransition(
                            child: DashboardScreen(),
                            type: PageTransitionType.rightToLeft
                        ),
                        //MaterialPageRoute(builder: (context) => DashboardScreen()),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: Text("LOG IN", style: TextStyle(fontSize: 20),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "No account yet? Sign up here!"
                  ),
                ),
                ElevatedButton( // Register Button
                  onPressed: () async { // anonyme und asynchrone Funktion
                    Navigator.push(
                      context,
                      PageTransition(
                          child: CreateAccount(),
                          type: PageTransitionType.bottomToTop
                      ),
                      //MaterialPageRoute(builder: (context) => CreateAccount()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                    child: Text("SIGN UP", style: TextStyle(fontSize: 15),),
                  ),
                ),
                ElevatedButton( // Forgot Password
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () async { // anonyme und asynchrone Funktion
                    //Navigator.push(
                    //  context,
                      //MaterialPageRoute(builder: (context) => LoginScreen()),
                    //);
                    print(usersList);
                  },
                  child: Text("forgot password?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkUser(String email, String password) {
    int userId = -1;
    for (int i = 0; i < usersList.length; i++) {
      if (usersList[i]['email'] == email && usersList[i]['password'] == password) {
        userId = usersList[i]['id'];
        //print("Login User : ${userId} oder auch id: ${usersList[i]['id']}");
        //print("registrierter Nutzer: ${registeredUserMap}");
        break;
      }
    }
    return userId;
  }
}

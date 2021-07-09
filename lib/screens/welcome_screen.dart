import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_pay/widgets.dart';
import 'package:social_pay/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static var gsheets, ss, sheet1;
  String username;
  String pass;
  int x = 0;
  String validation = '';
  List<String> usernames;
  bool spinner = false;

  void getUser() async {
    //WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = prefs.getString('user');
    print(currentUser);
    if (currentUser == 'Poonam') {
      Navigator.pushReplacementNamed(context, 'admin');
    } else if (currentUser != null) {
      Navigator.pushReplacementNamed(context, 'screen');
    } else {
      print('no login');
    }
    gsheets = GSheets(credentials);
    ss = await gsheets.spreadsheet(spreadsheetId);
    sheet1 = ss.worksheetByTitle("February");
    List<String> us = await sheet1.values.column(1, fromRow: 2);
    usernames = us;
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/p1.jpeg'), fit: BoxFit.cover),
        ),
        child: ModalProgressHUD(
          inAsyncCall: spinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset('images/logo.png'),
                      height: 65.0,
                    ),
                    TypewriterAnimatedTextKit(
                      text: ['Social Pay'],
                      textStyle: TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                    style: kDrawerTS.copyWith(fontSize: 15.0),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      username = value;
                      setState(() {
                        validation = '';
                      });
                    },
                    decoration: kInputDecor),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    style: kDrawerTS.copyWith(fontSize: 15.0),
                    onChanged: (value) {
                      pass = value;
                      setState(() {
                        validation = '';
                      });
                    },
                    decoration:
                        kInputDecor.copyWith(hintText: 'Enter Password')),
                SizedBox(
                  height: 24.0,
                ),
                NewWidget(
                  name: 'Login',
                  onPressed: () async {
                    setState(() {
                      spinner = true;
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (pass == 'Web@601') {
                      for (int i = 0; i < usernames.length; i++) {
                        if (username.toUpperCase() == usernames[i].toUpperCase()) {
                          if (username == 'Poonam'||username == 'poonam'||username == 'POONAM') {
                            Navigator.pushReplacementNamed(context, 'admin');
                            prefs.setString('user', usernames[i]);
                            x = 37;
                          }
                          else{
                            x = i + 2;
                            prefs.setInt('x', x);
                            prefs.setString('user', usernames[i]);
                            Navigator.pushReplacementNamed(context, 'screen');
                          }
                        }
                      }
                      x == 0 ? setState(() {
                              validation = 'Invalid Username or Password';
                              spinner = false; })
                          : setState(() {
                              spinner = false;
                            });
                    } else {
                      setState(() {
                        validation = 'Invalid Username or Password';
                        spinner = false;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    '$validation',
                    style: kDrawerTS.copyWith(
                        decoration: TextDecoration.underline, fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

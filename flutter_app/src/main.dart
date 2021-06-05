import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart'; // for changing the statusbar color

import 'package:firebase_core/firebase_core.dart';

import 'read_database.dart';
import 'firebase_notification.dart';


//import 'dart:developer';  // for debugging purposes


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  notification();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MyApp();
  }
}


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF3C7D2C)); // sets the color of the statusbar to green when in the app
    return MaterialApp(
      title: 'CTSOS',

      theme: ThemeData(

        // matched the color from https://imagecolorpicker.com/en/
        // got the Android color code from https://convertingcolors.com/rgb-color-60_125_44.html?search=RGB(60,%20125,%2044)
        primarySwatch: MaterialColor(0xFF3C7D2C, {
          50:Color.fromRGBO(60, 145, 44, .1),
          100:Color.fromRGBO(60, 145, 44, .2),
          200:Color.fromRGBO(60, 145, 44, .3),
          300:Color.fromRGBO(60, 145, 44, .4),
          400:Color.fromRGBO(60, 145, 44, .5),
          500:Color.fromRGBO(60, 145, 44, .6),
          600:Color.fromRGBO(60, 145, 44, .7),
          700:Color.fromRGBO(60, 145, 44, .8),
          800:Color.fromRGBO(60, 145, 44, .9),
          900:Color.fromRGBO(60, 145, 44, 1),
        }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'CTSOS Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget subStatus = Text("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 1),
            Padding(
              padding: EdgeInsets.all(75.0),
              child: new Text('Are chicken tender subs on sale?',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: new TextStyle(fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.w600,)),
            ),

            subStatus,
            Spacer(),
            new MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 5.0,
              minWidth: 100.0,
              height: 45,
              color: Color(0xFF3C7D2C),
              child: new Text('Check', //'Preciso de ajuda',
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                HapticFeedback.vibrate();
                setState(() {
                    subStatus = GetSaleStatus();
                });
              },
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

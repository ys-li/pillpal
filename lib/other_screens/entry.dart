import 'package:flutter/material.dart';
import 'PageCamera.dart';
import 'PageDashboard.dart';
import 'PageSocial.dart';
import '../main.dart';
import 'startup_screens.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'PillPal Alpha',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
        ),
      ),
      home: StartupScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final PageController pageController = PageController(initialPage: 1, keepPage: true, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        PageDashboard(),
        PageCamera(cameras),
        PageSocial(cameras),
      ],
      controller: pageController,
    );
  }
}

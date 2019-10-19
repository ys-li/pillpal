import 'package:flutter/material.dart';
import 'entry.dart';
import '../main.dart';


class StartupScreen extends StatefulWidget {
  StartupScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: Text(widget.title),
      //),
      body: PageView(
        children: <Widget>[
          SizedBox(
            child: Image.asset('assets/Splash.png', fit: BoxFit.fill),
            width: 10000.0,
            height: 10000.0,
          ),
          SizedBox(
            child: Image.asset('assets/Create Account.png', fit: BoxFit.fill),
            width: 10000.0,
            height: 10000.0,
          ),
          SizedBox(
            child: Image.asset('assets/Add Activities.png', fit: BoxFit.fill),
            width: 10000.0,
            height: 10000.0,
          ),
          SizedBox(
            child: Image.asset('assets/Easy Track Activities.png', fit: BoxFit.fill),
            width: 10000.0,
            height: 10000.0,
          ),
          new GestureDetector(
              onTap: (){
                //TODO: Go to Homescreen
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainScreen(title: "PillPal")));
              },
              child: Scaffold(
                body: SizedBox(
                  child: Image.asset('assets/View Weekly Progress.png', fit: BoxFit.fill),
                  width: 10000.0,
                  height: 10000.0,
                ),
                floatingActionButton: FloatingActionButton(onPressed: () { cameraSide = 1; Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainScreen(title: "PillPal")));} , child: Icon(Icons.navigate_next)),
              ),
          ),
        ],
      ),
    );
  }
}
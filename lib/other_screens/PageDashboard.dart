import 'package:flutter/material.dart';

class PageDashboard extends StatefulWidget {
  PageDashboard({Key key}) : super(key: key);

  @override
  _PageDashboardState createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    _FriendsWidget(),
    _MeWidget(),
    _AgendaWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("Friends")),
          BottomNavigationBarItem(icon: Icon(Icons.explore), title: Text("Groups")),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text("Agenda")),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Container(
        width: 10000.0,
        color: Colors.white,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

class _MeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Image.asset(
        'assets/You Page.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class _FriendsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Image.asset(
        'assets/Friends.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class _AgendaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Image.asset(
        'assets/Drug Schedule - Agenda Combined.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

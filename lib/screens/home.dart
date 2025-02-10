import 'package:flutter/material.dart';
import '../user_quizzes_list.dart';
import '../my_card.dart';
import '../widgets/lineup_full_widget.dart';
import '../leaderboard.dart';
import '../settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() =>
      _HomeState();
}

class _HomeState
    extends State<Home> {
  int _selectedIndex = 2;
  static final List<Widget> _widgetOptions = <Widget>[
    ShowQuizzesScreen(),
    MyCard(),
    LineupPage(userLineup: true),
    Leaderboard(),
    Settings()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Mosab2a',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.switch_account),
            label: 'My Card',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/tactics.png')),
            label: 'Lineup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
      ),
    );
  }
}
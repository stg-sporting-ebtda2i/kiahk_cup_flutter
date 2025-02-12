import 'package:flutter/material.dart';
import 'show_quizzes_list.dart';
import 'my_card.dart';
import 'lineup.dart';
import '../widgets/leaderboard.dart';
import 'more_options.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  int _selectedIndex = 2;
  static final List<Widget> _widgetOptions = <Widget>[
    ShowQuizzesPage(),
    MyCardPage(),
    LineupPage(userLineup: true),
    Leaderboard(),
    MoreOptionsPage()
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
            icon: Icon(Icons.more_horiz),
            label: 'More',
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
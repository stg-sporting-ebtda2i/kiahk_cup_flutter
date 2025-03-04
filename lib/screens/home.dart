import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:provider/provider.dart';
import 'show_quizzes_list.dart';
import 'my_card.dart';
import 'lineup.dart';
import '../widgets/leaderboard.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 2;
  final List<Widget> _widgetOptions = <Widget>[];

  @override
  void initState() {
    super.initState();
    ButtonsVisibilityProvider provider = context.read<ButtonsVisibilityProvider>();
    if (provider.isVisible('Mosab2a')) _widgetOptions.add(ShowQuizzesPage());
    if (provider.isVisible('Card')) _widgetOptions.add(MyCardPage());
    if (provider.isVisible('Lineup')) {
      _widgetOptions.add(LineupPage(userLineup: true, userId: -1));
      _selectedIndex = _widgetOptions.length-1;
    } else {
      _selectedIndex = 0;
    }
    if (provider.isVisible('Leaderboard')) _widgetOptions.add(Leaderboard());
    _widgetOptions.add(MoreOptionsPage());
    // ButtonsVisibilityProvider provider = context.read<ButtonsVisibilityProvider>();
    // provider.addListener(() {
    //   _updateWidgetOptions(provider);
    // });
  }

  void _updateWidgetOptions(ButtonsVisibilityProvider provider) {
    if(mounted) {
      setState(() {
        _widgetOptions.clear();
        if (provider.isVisible('Mosab2a')) _widgetOptions.add(ShowQuizzesPage());
        if (provider.isVisible('Card')) _widgetOptions.add(MyCardPage());
        if (provider.isVisible('Lineup')) {
          _widgetOptions.add(LineupPage(userLineup: true, userId: -1));
          _selectedIndex = _widgetOptions.length-1;
        } else {
          _selectedIndex = 0;
        }
        if (provider.isVisible('Leaderboard')) _widgetOptions.add(Leaderboard());
        _widgetOptions.add(MoreOptionsPage());
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ButtonsVisibilityProvider provider = context.read<ButtonsVisibilityProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _widgetOptions.isNotEmpty ? _widgetOptions.elementAt(_selectedIndex) : CircularProgressIndicator(),
      ),
      bottomNavigationBar: _widgetOptions.length>=2 ? BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          if (provider.isVisible('Mosab2a')) BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Mosab2a',
          ),
          if (provider.isVisible('Card')) BottomNavigationBarItem(
            icon: Icon(Icons.switch_account),
            label: 'My Card',
          ),
          if (provider.isVisible('Lineup')) BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/tactics.png')),
            label: 'Lineup',
          ),
          if (provider.isVisible('Leaderboard')) BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
      ) : Container(),
    );
  }
}
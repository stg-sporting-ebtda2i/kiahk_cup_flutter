import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/screens/requested_attendance_screen.dart';
import 'package:provider/provider.dart';
import 'show_quizzes_list.dart';
import 'lineup.dart';
import 'leaderboard.dart';
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
    if (provider.isVisible('Manage Attendance')) _widgetOptions.add(RequestedAttendance());
    if (provider.isVisible('Lineup')) {
      _widgetOptions.add(LineupPage(userLineup: true));
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
            icon: Icon(Icons.quiz_rounded),
            label: 'Mosab2a',
          ),
          if (provider.isVisible('Manage Attendance')) BottomNavigationBarItem(
            icon: Icon(Icons.church),
            label: 'Hodour',
          ),
          if (provider.isVisible('Lineup')) BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/tactics.png')),
            label: 'Lineup',
          ),
          if (provider.isVisible('Leaderboard')) BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_rounded),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.brand,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
      ) : Container(),
    );
  }
}
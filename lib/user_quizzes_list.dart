import 'package:flutter/material.dart';

class UserQuizzesList extends StatefulWidget {
  const UserQuizzesList({super.key});

  @override
  State<UserQuizzesList> createState() => _UserQuizzesListState();
}

class _UserQuizzesListState extends State<UserQuizzesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            const Image(
              image: AssetImage('assets/lineup_background.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Text(
                'Index 0: Home',
              ),
            ),
          ],
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/providers/leaderboard_provider.dart';
import 'package:piehme_cup_flutter/providers/user_provider.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/leaderboard_listitem.dart';
import 'package:provider/provider.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaderboardProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/backgrounds/leaderboard_background1.jpg'),
              )
          ),
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topRight,
          //     end: Alignment.bottomLeft,
          //     colors: [
          //       Color(0xFF020206),
          //       Color(0xFF16393F),
          //       Color(0xFF8A7C57),
          //     ],
          //   ),
          // ),
          child: Column(
            children: [
              SizedBox(
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 26),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black87,
                          Colors.black45,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Leaderboard',
                            style: const TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Header(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child:
              RefreshIndicator(
                onRefresh: () async {
                  await Loading.show(() async {
                    await context.read<LeaderboardProvider>().loadLeaderboard();
                  }, message: 'Loading Leaderboard...', delay: Duration.zero);
                },
                color: Colors.black,
                backgroundColor: Colors.greenAccent,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: provider.leaderboard.length,
                  itemBuilder: (context, index) {
                    return LeaderboardListItem(
                      current: userProvider.user.id == provider.leaderboard[index].id,
                        user: provider.leaderboard[index], index: index+1);
                  },
                ),
              ),
              ),
            ],
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/providers/leaderboard_provider.dart';
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
    return Scaffold(
        body: Stack(
          children: [
            const Image(
              image: AssetImage('assets/other_background.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                SafeArea(child: Header()),
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: provider.leaderboard.length,
                    itemBuilder: (context, index) {
                      return LeaderboardListItem(user: provider.leaderboard[index], index: index+1);
                    },
                  ),
                ),
                ),
              ],
            ),
          ],
        )
    );
  }
}

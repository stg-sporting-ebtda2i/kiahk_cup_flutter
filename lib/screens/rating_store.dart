import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/rating_store_provider.dart';
import 'package:piehme_cup_flutter/services/card_rating_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:provider/provider.dart';

class RatingStorePage extends StatefulWidget {
  const RatingStorePage({super.key});

  @override
  State<RatingStorePage> createState() => _RatingStorePageState();
}

class _RatingStorePageState extends State<RatingStorePage> {

  int delta = 0;
  late RatingStoreProvider provider;
  late LineupProvider lineupProvider;

  void _incRating() {
    if ((provider.currentRating+delta)<99) {
      setState(() {
        delta++;
      });
    }
  }

  void _decRating() {
    if ((provider.currentRating+delta)>50) {
      setState(() {
        delta--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<RatingStoreProvider>(context);
    lineupProvider = Provider.of<LineupProvider>(context);
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${provider.currentRating+delta}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 65,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        (provider.ratingPrice*delta) >= 0 ? '${provider.ratingPrice*delta*-1} €' : '+${provider.ratingPrice*delta*-1} €',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => _decRating(),
                            child: Icon(
                              Icons.remove_circle_rounded,
                              color: Colors.white70,
                              size: 60,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _incRating(),
                            child: Icon(
                              Icons.add_circle_rounded,
                              color: Colors.white70,
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 17,),
                      SizedBox(
                        width: 205,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => ActionUtils(
                            delay: 0,
                              context: context,
                              action: () => CardRatingService.upgradeRating(delta),
                              callback: () async {
                                delta = 0;
                                provider.loadData();
                                await lineupProvider.loadLineup(-1);
                              }
                          ).confirmAction(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            'Purchase',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

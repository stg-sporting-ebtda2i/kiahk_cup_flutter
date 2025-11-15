import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/rating_store_provider.dart';
import 'package:piehme_cup_flutter/services/card_rating_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';
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
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.only(top: 20, left: 32, right: 16, bottom: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rating',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white70),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${provider.currentRating+delta}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 60,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (provider.ratingPrice*delta) >= 0 ? '${provider.ratingPrice*delta*-1}' : '+${provider.ratingPrice*delta*-1}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8,),
                  Image.asset(
                    'assets/icons/coin.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _decRating(),
                    child: Icon(
                      Icons.remove_circle_rounded,
                      color: Colors.white70,
                      size: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _incRating(),
                    child: Icon(
                      Icons.add_circle_rounded,
                      color: Colors.white70,
                      size: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 17,),
              SizedBox(
                width: 205,
                child: CustomButton(
                    text: 'Purchase',
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
                    isLoading: false,
                  verticalPadding: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

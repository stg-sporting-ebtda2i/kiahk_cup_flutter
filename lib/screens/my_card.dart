import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/screens/positions_store.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/my_card_icon_button.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';
import 'package:provider/provider.dart';
import '../widgets/user_card.dart';

class MyCardPage extends StatefulWidget {
  const MyCardPage({super.key});

  @override
  State<MyCardPage> createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage> {
  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height / 2.3;
    LineupProvider provider = Provider.of<LineupProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        const Image(
          image: AssetImage('assets/backgrounds/user_card_background.jpg'),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 130,
              child: SafeArea(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'My Card',
                        style: const TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        // textAlign: TextAlign.left,
                      ),
                    ),
                    Header(),
                  ],
                ),
              ),
            ),
            Hero(
              tag: "user-card",
              child: SizedBox(
                width: 900 * cardHeight / 1266,
                height: cardHeight,
                child: UserCard(
                  width: 900 * cardHeight / 1266,
                  user: provider.user,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(55, 30, 50, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyCardIconButton(
                      text: 'Position',
                      iconPath: 'assets/icons/position.png',
                      callback: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return PositionsStorePage();
                            });
                      }),
                  MyCardIconButton(
                      text: 'Card',
                      iconPath: 'assets/icons/card.png',
                      callback: () {}),
                  MyCardIconButton(
                      text: 'Rating',
                      iconPath: 'assets/icons/rating.png',
                      callback: () {}),
                  MyCardIconButton(
                      text: 'Picture',
                      iconPath: 'assets/icons/picture.png',
                      callback: () {}),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

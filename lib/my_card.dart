import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/header.dart';
import 'player_card.dart';
import 'styles.dart';
import 'header.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            const Image(
              image: AssetImage('assets/other_background.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Column(
                children: [
                  SafeArea(child: Header()),
                  Expanded(child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 330,
                          height: 472,
                          child: PlayerCard(width: 330),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: btnStyle(),
                                child: Text(
                                  'Position',
                                  style: btnTextStyle(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: btnStyle(),
                                child: Text(
                                  'Card',
                                  style: btnTextStyle(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: btnStyle(),
                                child: Text(
                                  'Rating',
                                  style: btnTextStyle(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),),
                ],
              ),
            ),
          ],
        )
    );
  }
}

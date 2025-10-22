import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
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
    final cardHeight = MediaQuery.of(context).size.height/2;
    LineupProvider provider = Provider.of<LineupProvider>(context);
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
                          width: 900*cardHeight/1266,
                          height: cardHeight,
                          child: UserCard(
                            width: 900*cardHeight/1266,
                            user: provider.user,
                          ),
                        ),
                        SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                text: 'Position',
                                isLoading: false,
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.positionsStore);
                                },
                              ),
                              CustomButton(
                                text: 'Card',
                                isLoading: false,
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.cardsStore);
                                },
                              ),
                              CustomButton(
                                text: 'Rating',
                                isLoading: false,
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.ratingStore);
                                },
                              ),
                            ],
                          ),
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

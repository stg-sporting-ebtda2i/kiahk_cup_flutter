import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/base_lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/utils/card_utils.dart';
import 'package:provider/provider.dart';

class Lineup extends StatefulWidget {
  final bool userLineup;
  final BaseLineupProvider provider;

  const Lineup({
    super.key,
    required this.userLineup,
    required this.provider,
  });

  @override
  State<Lineup> createState() => _LineupState();
}

class _LineupState extends State<Lineup> with SingleTickerProviderStateMixin {
  late double _cardHeight;
  late bool _storeOpened = false;
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;
  late List<Animation<Offset>> _cardPositions;

  @override
  void initState() {
    super.initState();
    _storeOpened = context.read<ButtonsVisibilityProvider>().isVisible('Store');
    widget.provider.resetAddedCards();

    // Big animation controller
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    // Scale animations
    _cardAnimations = List.generate(11, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            (0.08 * index).clamp(0.0, 0.8),
            (0.08 * index + 0.4).clamp(0.0, 1.0),
            curve: Curves.elasticOut,
          ),
        ),
      );
    });

    // Position animations - cards fly in from different directions
    _cardPositions = List.generate(11, (index) {
      Offset startOffset;

      // Assign different starting positions based on card position
      if (index == 0) {
        startOffset = Offset(-2.0, 0.0); // LW from left
      } else if (index == 2) {
        startOffset = Offset(2.0, 0.0);
      } // RW from right
      else if (index == 1) {
        startOffset = Offset(0.0, -2.0);
      } // ST from top
      else if (index >= 3 && index <= 5) {
        startOffset = Offset(0.0, -1.5);
      } // Midfield from top
      else if (index >= 6 && index <= 9) {
        startOffset = Offset(0.0, 1.5);
      } // Defense from bottom
      else {
        startOffset = Offset(0.0, 2.0);
      } // GK from bottom

      return Tween<Offset>(
        begin: startOffset,
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            (0.08 * index).clamp(0.0, 0.8),
            (0.08 * index + 0.4).clamp(0.0, 1.0),
            curve: Curves.elasticOut,
          ),
        ),
      );
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cardHeight = MediaQuery.of(context).size.height / 6.7;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Front Row (LW, ST, RW)
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnimatedCard('LW', 0),
              Transform.translate(
                offset: Offset(0, -40),
                child: _buildAnimatedCard('ST', 1),
              ),
              _buildAnimatedCard('RW', 2),
            ],
          ),
        ),
        // Back Row (LCM, CAM, RCM)
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnimatedCard('CM', 3),
              Transform.translate(
                offset: Offset(0, -30),
                child: _buildAnimatedCard('CAM', 4),
              ),
              _buildAnimatedCard('CM', 5),
            ],
          ),
        ),
        // Center Row (LB, LCB, RCB, RB)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnimatedCard('LB', 6),
            _buildAnimatedCard('CB', 7),
            _buildAnimatedCard('CB', 8),
            _buildAnimatedCard('RB', 9),
          ],
        ),
        // Goalkeeper (GK)
        _buildAnimatedCard('GK', 10),
      ],
    );
  }

  Widget _buildAnimatedCard(String position, int animationIndex) {
    return AnimatedBuilder(
      animation: Listenable.merge(
          [_cardAnimations[animationIndex], _cardPositions[animationIndex]]),
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
              _cardPositions[animationIndex].value.dx *
                  100, // Convert offset to pixels
              _cardPositions[animationIndex].value.dy * 50,
            )
            ..scale(_cardAnimations[animationIndex].value),
          child: Opacity(
            opacity: _cardAnimations[animationIndex].value,
            child: child,
          ),
        );
      },
      child: getCard(position),
    );
  }

  Widget getCard(String position) {
    return CardsUtils.getCard(
        position: position,
        context: context,
        cardHeight: _cardHeight,
        clickable: widget.userLineup && _storeOpened,
        provider: widget.provider);
  }
}

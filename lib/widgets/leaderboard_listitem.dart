import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/providers/other_lineup_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/action_icon_button.dart';
import 'package:piehme_cup_flutter/widgets/lineup_scores_panel.dart';
import 'package:piehme_cup_flutter/widgets/user_card.dart';
import 'package:provider/provider.dart';

class LeaderboardListItem extends StatelessWidget {
  final bool current;
  final User user;
  final int index;

  const LeaderboardListItem({
    super.key,
    required this.current,
    required this.user,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getCardColor(),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(102),
            blurRadius: 15,
            offset: Offset(0, 6),
            spreadRadius: 1,
          ),
          if (current)
            BoxShadow(
              color: Colors.amber.withAlpha(128),
              blurRadius: 25,
              spreadRadius: 3,
            ),
        ],
        border: current
            ? Border.all(
                color: Colors.amber,
                width: 2.5,
              )
            : Border.all(
                color: Colors.white.withAlpha(38),
                width: 1.2,
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _viewLineup(context),
          borderRadius: BorderRadius.circular(18),
          splashColor: Colors.amber.withAlpha(77),
          highlightColor: Colors.amber.withAlpha(38),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Rank with enhanced styling
                _buildEnhancedRankIndicator(),
                SizedBox(width: 6),

                // User Card with better proportions
                _buildEnhancedUserCard(),
                SizedBox(width: 6),

                // Stats Section with improved layout
                Expanded(
                  child: _buildEnhancedStatsSection(),
                ),
                SizedBox(width: 6),
                // Action Button with better styling
                ActionIconButton(
                    icon: ImageIcon(
                      AssetImage('assets/icons/tactics.png'),
                      color: Colors.blue,
                      size: 20,
                    ),
                    color: Colors.blue,
                    onPressed: () => _viewLineup(context),
                    tooltip: "View Lineup")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedRankIndicator() {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: _getRankColor(),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(75),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.white.withAlpha(26),
            blurRadius: 2,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              index.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black.withAlpha(75),
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedUserCard() {
    return UserCard(
      width: 110,
      user: user,
    );
  }

  Widget _buildEnhancedStatsSection() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Rating Section with enhanced styling
          _buildPremiumStatContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: StarRatingProgress(
                      rating: (user.lineupRating / 100 * 5).round(), starSize: 18),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber.withAlpha(51),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.amber.withAlpha(102),
                    ),
                  ),
                  child: Text(
                    user.lineupRating.round().toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            label: 'RATING',
          ),

          SizedBox(
            height: 8,
          ),

          // Chemistry Section with enhanced styling
          _buildPremiumStatContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 10,
                    child: LinearProgressIndicator(
                      value: user.chemistry/33,
                      backgroundColor: Colors.grey.shade700,
                      color: Color(0xFFFAD361),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAD361).withAlpha(51),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFFFAD361).withAlpha(102),
                    ),
                  ),
                  child: Text(
                    user.chemistry.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFFAD361),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            label: 'CHEMISTRY',
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumStatContainer(
      {required Widget child, required String label}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(102),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withAlpha(38),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  void _viewLineup(BuildContext context) async {
    final otherLineupProvider = context.read<OtherLineupProvider>();
    await otherLineupProvider.loadLineup(user.id);
    if (!context.mounted) return;
    Navigator.pushNamed(
      context,
      AppRoutes.lineup,
      arguments: {'userLineup': false},
    );
  }

  Color _getCardColor() {
    if (current) return Colors.grey[850]!.withAlpha(230);
    if (index == 1) return Colors.grey[900]!.withAlpha(220);
    return Colors.grey[900]!.withAlpha(200);
  }

  Color _getRankColor() {
    if (index == 1) return Colors.amber.shade400;
    if (index == 2) return Colors.grey.shade400;
    if (index == 3) return Colors.orange.shade500;
    return Colors.blue.shade600;
  }
}

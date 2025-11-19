import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
import 'package:piehme_cup_flutter/providers/user_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';

class MoreOptionsPage extends StatefulWidget {
  const MoreOptionsPage({super.key});

  @override
  State<MoreOptionsPage> createState() => _MoreOptionsPageState();
}

class _MoreOptionsPageState extends State<MoreOptionsPage> {
  bool _confirmed = true;

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => alertDialog(
        context: context,
        text: 'Are you sure that you want to logout?',
        positiveBtnText: 'Logout',
        positiveBtnAction: () {
          context.read<HeaderProvider>().stop();
          AuthService.logout();
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
      ),
    );
  }

  void _delete() {
    showDialog(
      context: context,
      builder: (context) => alertDialog(
        context: context,
        text: 'Are you sure that you want to delete your account?',
        positiveBtnText: 'Delete',
        positiveBtnAction: () async {
          await AuthService.delete();
          if (!context.mounted) return;
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color(0xFF0A1F3A), // Dark blue
        //       Color(0xFF1A3A5F), // Medium blue
        //       Color(0xFF2D4A7A), // Light blue
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
          image: DecorationImage(
              image: AssetImage(
                  'assets/backgrounds/profile_background3.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: [
            // Enhanced Header
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 26),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
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
                        'Profile',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      Header(),
                    ],
                  ),
                ),
              ),
            ),

            Consumer2<ButtonsVisibilityProvider, UserProvider>(
              builder: (context, provider, userProvider, child) {
                return Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Profile Header Section
                        Container(
                          padding: const EdgeInsets.all(24),
                          margin: const EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.15),
                                Colors.white.withOpacity(0.08),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // User Avatar
                              Stack(
                                children: [
                                  Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(image: AssetImage('assets/backgrounds/profile_background3.png'), fit: BoxFit.cover),
                                      // gradient: LinearGradient(
                                      //   colors: [
                                      //     Colors.blue.shade800.withAlpha(200),
                                      //     Colors.blue.shade900.withAlpha(200),
                                      //   ],
                                      //   begin: Alignment.topRight,
                                      //   end: Alignment.bottomLeft,
                                      // ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.yellow.shade200.withOpacity(0.4),
                                          blurRadius: 30,
                                          offset: const Offset(3, 6),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ClipOval(
                                        child: userProvider.user.imageUrl != null
                                            ? CachedNetworkImage(
                                          imageUrl: userProvider.user.imageUrl!,
                                          cacheKey: userProvider.user.imageKey,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[800],
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[800],
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.person_rounded,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                        )
                                            : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.person_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (userProvider.isLoading)
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // User Name
                              Text(
                                userProvider.user.name ?? 'User',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        // About App Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.12),
                                Colors.white.withOpacity(0.06),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.games_rounded,
                                    color: Colors.blue.shade300,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'About The App',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              _buildAboutRow(
                                icon: Icons.flag_rounded,
                                text: 'The Road to Bethlehem',
                              ),
                              const SizedBox(height: 12),

                              _buildAboutRow(
                                icon: Icons.group_rounded,
                                text: 'خدمة ابتدائي - St. George Sporting',
                              ),
                              const SizedBox(height: 12),

                              _buildAboutRow(
                                icon: Icons.location_pin,
                                text: 'Alexandria, Egypt',
                              ),
                              const SizedBox(height: 12),

                              _buildAboutRow(
                                icon: Icons.phone_android_rounded,
                                text: 'Version 3.0.0 • 2025',
                              ),
                            ],
                          ),
                        ),

                        // Action Buttons Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.12),
                                Colors.white.withOpacity(0.06),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Logout Button
                              _buildEnhancedProfileButton(
                                icon: Icons.logout_rounded,
                                title: 'Logout',
                                subtitle: 'Sign out of your account',
                                onTap: _logout,
                                color: Colors.red.shade400,
                              ),
                              if (!_confirmed)
                              const SizedBox(height: 16),

                              // Delete Account Button
                              if (!_confirmed)
                                _buildEnhancedProfileButton(
                                  icon: Icons.delete_forever_rounded,
                                  title: 'Delete Account',
                                  subtitle: 'Permanently delete your account',
                                  onTap: _delete,
                                  color: Colors.red.shade700,
                                ),
                            ],
                          ),
                        ),

                        // App Footer
                        Container(
                          margin: const EdgeInsets.only(top: 25),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                'The Road to Bethlehem',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'St. George Sporting, Alex.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blue.shade300,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedProfileButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withOpacity(0.2),
        highlightColor: color.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.5),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/widgets_icon_button.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';
import 'package:piehme_cup_flutter/dialogs/attendance_dialog.dart';

class MoreOptionsPage extends StatefulWidget {
  const MoreOptionsPage({super.key});

  @override
  State<MoreOptionsPage> createState() => _MoreOptionsPageState();
}

class _MoreOptionsPageState extends State<MoreOptionsPage> {

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => alertDialog(
        context: context,
        text: 'Are you sure that you want to logout',
        negativeBtnText: 'Cancel',
        positiveBtnText: 'Logout',
        negativeBtnAction: () => Navigator.pop(context),
        positiveBtnAction: () {
          AuthService.logout();
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
      ),
    );
  }

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
          Column(
            children: [
              const SafeArea(child: Header()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      iconButton(
                        onClick: () {
                          showAttendanceDialog(
                              list: <String>['Madares Ahad', 'Odas el Atfal', 'Odas', 'Tasbeha','Salat Baker', 'Salat el Nom', 'Engeel'],
                              context: context,
                          );
                        },
                        icon: Icons.add_rounded,
                        text: 'Request Coins',
                      ),
                      SizedBox(height: 20,),
                      iconButton(
                        onClick: () {
                          Navigator.pushNamed(context, AppRoutes.changePicture);
                        },
                        icon: Icons.person,
                        text: 'Change Picture',
                      ),
                      SizedBox(height: 20,),
                      iconButton(
                          onClick: _logout,
                          icon: Icons.logout_rounded,
                          text: 'Logout',
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
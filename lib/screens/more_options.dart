import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/providers/attendance_provider.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/change_picture_service.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/widgets_icon_button.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';
import 'package:piehme_cup_flutter/dialogs/attendance_dialog.dart';
import 'package:provider/provider.dart';

class MoreOptionsPage extends StatefulWidget {
  const MoreOptionsPage({super.key});

  @override
  State<MoreOptionsPage> createState() => _MoreOptionsPageState();
}

class _MoreOptionsPageState extends State<MoreOptionsPage> {

  @override
  void initState() {
    super.initState();
    context.read<AttendanceProvider>().loadLiturgies();
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => alertDialog(
        context: context,
        text: 'Are you sure that you want to logout',
        positiveBtnText: 'Logout',
        positiveBtnAction: () {
          AuthService.logout();
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File selectedImage = File(image.path);
      EasyLoading.show(status: 'Loading...');
      try {
        await ChangePictureService.changePicture(selectedImage);
      } catch(e) {
        toastError(e.toString());
      } finally {
        EasyLoading.dismiss(animation: true);
      }
    } else {
      toastError('Error: empty image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
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
                              list: attendanceProvider.liturgyNames!,
                              context: context,
                          );
                        },
                        icon: Icons.add_rounded,
                        text: 'Request Coins',
                      ),
                      SizedBox(height: 20,),
                      if (context.read<ButtonsVisibilityProvider>().isVisible('Change Picture')) iconButton(
                        onClick: () {
                          _pickImage();
                        },
                        icon: Icons.person,
                        text: 'Change Picture',
                      ),
                      if (context.read<ButtonsVisibilityProvider>().isVisible('Change Picture')) SizedBox(height: 20,),
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
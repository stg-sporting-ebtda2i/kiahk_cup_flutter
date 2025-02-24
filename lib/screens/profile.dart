import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/providers/attendance_provider.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/providers/user_provider.dart';
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
    Provider.of<UserProvider>(context, listen: false).loadUserData();
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => alertDialog(
        context: context,
        text: 'Are you sure that you want to logout?',
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

    if (image == null) {
      return;
    }
    String imagePath = image.path;

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Crop your character',
          rotateButtonsHidden: true,
          minimumAspectRatio: 1.0,
          rectWidth: 3000,
          rectHeight: 3000,
          rectX: 1,
          rectY: 1,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );

    if(croppedFile == null) {
      return;
    }

    imagePath = croppedFile.path;

    File selectedImage = File(imagePath);
    await Loading.show(() async {
      await ChangePictureService.changePicture(selectedImage);
      if (mounted) {
        Provider.of<UserProvider>(context, listen: false).loadUserData();
      }

      toast("Image changed successfully");
    }, delay: Duration(milliseconds: 0), message: "Changing image...");
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
              Consumer<ButtonsVisibilityProvider>(
                  builder: (context, provider, child) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [

                        if (provider.isVisible('Change Picture'))
                          Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                                return GestureDetector(
                                  onTap: _pickImage,
                                  child: Column(
                                    children: [
                                      if(userProvider.user.imageUrl != null)
                                        CachedNetworkImage(
                                          imageUrl: userProvider.user.imageUrl!,
                                          cacheKey: userProvider.user.imageKey,
                                          imageBuilder: (context, imageProvider) =>
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    child: Visibility(
                                                      visible: userProvider.isLoading,
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  ),

                                                  Container(
                                                    margin: const EdgeInsets.only(top: 10),
                                                    child: Text(
                                                      'Change Image',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        ),

                                      if(userProvider.user.imageUrl == null)
                                        iconButton(
                                          onClick: _pickImage,
                                          icon: Icons.upload,
                                          text: 'Upload Image',
                                        ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        if (provider.isVisible('Change Picture'))
                          SizedBox(
                            height: 20,
                          ),

                        iconButton(
                          onClick: () {
                            showAttendanceDialog(
                              list: attendanceProvider.liturgyNames!,
                              context: context,
                            );
                          },
                          icon: Icons.add_rounded,
                          text: 'Hodour',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        iconButton(
                          onClick: _logout,
                          icon: Icons.logout_rounded,
                          text: 'Logout',
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

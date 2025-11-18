import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/user_provider.dart';
import 'package:piehme_cup_flutter/screens/icons_store.dart';
import 'package:piehme_cup_flutter/screens/positions_store.dart';
import 'package:piehme_cup_flutter/screens/rating_store.dart';
import 'package:piehme_cup_flutter/services/change_picture_service.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/my_card_icon_button.dart';
import 'package:provider/provider.dart';
import '../widgets/user_card.dart';

class MyCardPage extends StatefulWidget {
  const MyCardPage({super.key});

  @override
  State<MyCardPage> createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage> {

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    String imagePath = image.path;

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop character',
          toolbarWidgetColor: Colors.black,
        ),
        IOSUiSettings(
          title: 'Crop character',
          rotateButtonsHidden: true,
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
      await Future.delayed(Duration(seconds: 5));
      await Future.wait([
        if (mounted) context.read<UserProvider>().loadUserData(),
      ]);
      toast("Image changed successfully");
    }, delay: Duration(milliseconds: 0), message: "Changing image...");
  }

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
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 26),
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
                      callback: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return IconsStorePage();
                            });
                      }),
                  MyCardIconButton(
                      text: 'Rating',
                      iconPath: 'assets/icons/rating.png',
                      callback: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return RatingStorePage();
                            });
                      }),
                  MyCardIconButton(
                      text: 'Picture',
                      iconPath: 'assets/icons/picture.png',
                      callback: _pickImage),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

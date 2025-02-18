import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'dart:io';

import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/user_card.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';
import 'package:provider/provider.dart';

class ChangePicturePage extends StatefulWidget {
  const ChangePicturePage({super.key});

  @override
  State<ChangePicturePage> createState() => _ChangePicturePageState();
}

class _ChangePicturePageState extends State<ChangePicturePage> {

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _updateCard();
  }

  void _updateCard() {

  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path); // Convert XFile to File
      });
    }
  }

  void _saveImage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                          width: 330,
                          height: 472,
                          child: UserCard(
                            width: 330,
                            user: provider.user,
                            image: _selectedImage,
                          ),
                        ),
                        Button(
                          width: 240,
                          height: 52,
                          text: 'Select Picture',
                          isLoading: false,
                          fontSize: 18,
                          onClick: _pickImage,
                        ),
                        SizedBox(height: 10,),
                        if (_selectedImage!=null)Button(
                          width: 240,
                          height: 52,
                          text: 'Save Picture',
                          isLoading: false,
                          fontSize: 18,
                          onClick: _saveImage,
                        )
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
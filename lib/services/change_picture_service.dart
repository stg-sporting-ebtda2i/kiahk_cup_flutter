import 'dart:io';
import 'dart:developer';
import 'package:piehme_cup_flutter/request.dart';

class ChangePictureService {
  static Future<void> changePicture(File photo) async {
    await (await Request('/users/change-image').withToken())
        .addFile('image', photo)
        .put();
  }
}
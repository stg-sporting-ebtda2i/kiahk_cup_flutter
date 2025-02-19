import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';

class ChangePictureService {
  static Future<void> changePicture(File photo) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/users/change-image');
    try {
      var request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = 'Bearer ${await AuthService.getToken()}';
      var photoStream = http.ByteStream(photo.openRead());
      var photoLength = await photo.length();
      var multipartFile = http.MultipartFile(
        'image',
        photoStream,
        photoLength,
        filename: '${DateTime.now().millisecondsSinceEpoch}',
      );
      request.files.add(multipartFile);
      var response = await request.send();
      if (response.statusCode == 200) {
        throw 'Picture changed successfully';
      } else {
        throw 'Failed to change picture. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw '$e';
    }
  }
}
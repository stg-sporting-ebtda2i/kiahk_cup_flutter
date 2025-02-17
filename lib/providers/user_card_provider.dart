import 'package:flutter/cupertino.dart';

class UserCardProvider with ChangeNotifier {

  String _name = 'Loading';
  int _rating = 0;
  String _iconURL = '';
  String _imageURL = '';
  String _position = '';

  String get name => _name;
  int get rating => _rating;
  String get iconURL => _iconURL;
  String get imageURL => _imageURL;
  String get position => _position;

}
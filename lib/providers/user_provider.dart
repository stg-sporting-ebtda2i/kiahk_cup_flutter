import 'package:flutter/foundation.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/services/users_service.dart';

class UserProvider extends ChangeNotifier {
  User _user = User.empty();
  bool _isLoading = false;

  User get user => _user;
  bool get isLoading => _isLoading;

  void loadUserData() async {
    _isLoading = true;

    await Loading.show(() async {
      _user = await UsersService.getUserIcon();
      _isLoading = false;
      notifyListeners();
    });
  }
}
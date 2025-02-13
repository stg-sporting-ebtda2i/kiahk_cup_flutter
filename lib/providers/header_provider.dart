import 'dart:async';
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';

class HeaderProvider with ChangeNotifier {
  String? _name;
  int _coins = 0;
  Timer? _timer;

  String? get name => _name;
  int get coins => _coins;

  HeaderProvider() {
    _initialize();
  }

  void refreshCoins() async {
    _coins++;
    notifyListeners();
  }

  Future<void> _initialize() async {
    _name = await AuthService.getName();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      refreshCoins();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer
    super.dispose();
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';
import 'package:piehme_cup_flutter/services/coins_service.dart';

class HeaderProvider with ChangeNotifier {
  String? _name;
  int _coins = 0;
  Timer? _timer;

  String? get name => _name;
  int get coins => _coins;
  

  void refreshCoins() async {
    _coins = await CoinsService.getCoins();
    notifyListeners();
  }

  Future<void> initialize() async {
    _name = await AuthService.getName();
    _coins = await CoinsService.getCoins();
    notifyListeners();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      refreshCoins();
    });
  }

  void stop() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
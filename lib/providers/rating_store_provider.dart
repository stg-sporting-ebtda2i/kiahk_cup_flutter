import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/services/card_rating_service.dart';

class RatingStoreProvider with ChangeNotifier {

  int _currentRating = -1;
  int _ratingPrice = -1;

  int get currentRating => _currentRating;
  int get ratingPrice => _ratingPrice;

  void loadData() async {
    EasyLoading.show(status: 'Loading...');
    _currentRating = 0;
    _ratingPrice = 99999;
    try {
      _currentRating = await CardRatingService.getCardRating();
      _ratingPrice = await CardRatingService.getRatingPrice();
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

}
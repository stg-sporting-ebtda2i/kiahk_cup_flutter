import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/services/card_rating_service.dart';

class RatingStoreProvider with ChangeNotifier {

  int _currentRating = -1;
  int _ratingPrice = -1;

  int get currentRating => _currentRating;
  int get ratingPrice => _ratingPrice;

  Future<void> loadData() async {
    _ratingPrice = 0;

    _currentRating = await CardRatingService.getCardRating();
    _ratingPrice = await CardRatingService.getRatingPrice();
    notifyListeners();
  }

}
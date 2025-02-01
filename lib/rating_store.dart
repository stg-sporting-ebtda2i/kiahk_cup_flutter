import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/header.dart';

class RatingStorePage extends StatefulWidget {
  const RatingStorePage({super.key});

  final int ratingPrice = 70;
  final int reqAmount = 0;
  final int rating = 50;

  @override
  State<RatingStorePage> createState() => _RatingStorePageState();
}

class _RatingStorePageState extends State<RatingStorePage> {

  late int _ratingPrice;
  late int _reqAmount;
  late int _rating;

  @override
  void initState() {
    super.initState();
    _ratingPrice = widget.ratingPrice;
    _reqAmount = widget.reqAmount;
    _rating = widget.rating;
  }

  void _incRating() {
    if (_rating<99) {
      setState(() {
        _rating++;
        _reqAmount+=_ratingPrice;
      });
    }
  }

  void _decRating() {
    if (_rating>50) {
      setState(() {
        _rating--;
        _reqAmount-=_ratingPrice;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/other_background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              SafeArea(child: Header()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_rating',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 65,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$_reqAmount €',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => _decRating(),
                            child: Icon(
                              Icons.remove_circle_rounded,
                              color: Colors.white70,
                              size: 60,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _incRating(),
                            child: Icon(
                              Icons.add_circle_rounded,
                              color: Colors.white70,
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 17,),
                      SizedBox(
                        width: 205,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            'Purchase',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

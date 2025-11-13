import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardPlaceholder extends StatelessWidget {
  const CardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Image(
          image: AssetImage('assets/placeholder/card_placeholder.png'),
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Lottie.asset('assets/lottie/shining-stars-1.json'),
              ),
              SizedBox(height: 4,),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD1A000),
                )),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCardIconButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback callback;

  const MyCardIconButton(
      {super.key,
      required this.text,
      required this.iconPath,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 55,
            height: 55,
            child: Image.asset(iconPath),
          ),
          SizedBox(height: 7),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 11
            ),
          )
        ],
      ),
    );
  }
}

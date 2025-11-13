import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headerProvider = Provider.of<HeaderProvider>(context);
    return Row(
      children: [
        Text(
          headerProvider.coins.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 21,
              color: Colors.white,
              fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Image.asset(
          'assets/icons/coin.png',
          width: 23,
          height: 23,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 24),
      ],
    );
  }
}

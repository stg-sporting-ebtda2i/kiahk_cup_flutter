import 'package:flutter/material.dart';

Widget loginTextField({
  required TextEditingController controller,
  required String hint,
  required bool obscureText,
}) {
  return TextField(
    controller: controller,
    cursorColor: Colors.greenAccent,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      filled: true,
      fillColor: Colors.black54,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.greenAccent, width: 1),
      ),
    ),
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    obscureText: obscureText,
  );
}
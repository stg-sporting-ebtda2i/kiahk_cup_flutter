import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final Color borderColor;

  const CustomOutlinedButton({
    super.key,
    this.borderColor = const Color(0xFF757575),
    this.text = 'Cancel',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade400,
                    fontFamily: 'Dubai'
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

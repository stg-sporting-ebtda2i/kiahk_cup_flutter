import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  final Widget icon;
  final Color color;
  final VoidCallback onPressed;
  final String tooltip;

  const ActionIconButton(
      {super.key,
      required this.icon,
      required this.color,
      required this.onPressed,
      required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          shape: BoxShape.circle,
          border: Border.all(color: color.withAlpha(77)),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          padding: EdgeInsets.all(6),
          constraints: BoxConstraints(minWidth: 36, minHeight: 36),
        ),
      ),
    );
  }
}

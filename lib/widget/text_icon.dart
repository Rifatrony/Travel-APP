import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final double iconSize;
  final double size;
  const TextIcon({
    super.key,
    required this.text,
    required this.icon,
    this.iconSize = 16,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        Icon(
          icon,
          size: size,
        )
      ],
    );
  }
}

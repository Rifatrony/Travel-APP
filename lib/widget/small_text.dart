import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  const SmallText({super.key, required this.text, this.size = 14, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color
      ),
    );
  }
}

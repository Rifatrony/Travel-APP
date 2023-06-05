import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  const BigText({super.key, required this.text, this.size = 18, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        color: color
      ),
    );
  }
}

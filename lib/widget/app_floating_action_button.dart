import 'package:flutter/material.dart';

class AppFloatingActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  const AppFloatingActionButton({
    super.key,
    required this.title,
    required this.onPress,
    this.height = 45,
    this.width = 140,
    this.color = Colors.redAccent,
    this.textColor = Colors.white,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        elevation: 0,
        onPressed: onPress,
        backgroundColor: color,
        child: Text(
          title,
          style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

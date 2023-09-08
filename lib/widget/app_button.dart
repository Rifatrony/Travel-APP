// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:travel_app/utils/diamention.dart';

class AppButton extends StatelessWidget {
  final String title;
  VoidCallback onPress;
  final double? height;
  final double? width;
  final double? radius;
  final double? size;
  final Color? buttonColor;
  final Color? textColor;
  final bool? loading;

  AppButton({
    super.key,
    required this.onPress,
    required this.title,
    this.height = 50,
    this.width = double.maxFinite,
    this.radius = 30,
    this.size = 16,
    this.buttonColor = Colors.purple,
    this.textColor = Colors.white,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Diamentions.width16,
        right: Diamentions.width16,
        top: Diamentions.font20,
        bottom: Diamentions.height16,
      ),
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius!),
            color: buttonColor,
          ),
          child: Center(
            child: loading == false? Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: size,
              ),
            ) : const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

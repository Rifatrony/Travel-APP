import 'package:flutter/material.dart';
import 'package:travel_app/utils/diamention.dart';

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  final double? valueSize;
  final FontWeight? valueFontWidget;
  final Color? color;
  final Color? valueColor;
  const ReusableRow({
    super.key,
    required this.title,
    required this.value,
    this.color = Colors.white,
    this.valueColor = Colors.white,
    this.valueSize = 14,
    this.valueFontWidget = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Diamentions.width5,
        right: Diamentions.width5,
        top: Diamentions.height5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              color: valueColor,
              fontWeight: valueFontWidget,
            ),
          ),
        ],
      ),
    );
  }
}

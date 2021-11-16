import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight fontWeight;
  final Alignment? alignment;
  final Color? color;

  const CustomText(
    this.text, {
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.alignment,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}

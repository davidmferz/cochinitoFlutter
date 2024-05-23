import 'package:flutter/material.dart';

class CustomButtonStyle {
  static ButtonStyle elevatedStyleButton({
    required Color colorStyle,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: colorStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  static  Text rawButtonText({
    required String text,
    Color? color,
    double? fontSize,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize ?? 18,
      ),
    );
  }

  static EdgeInsetsGeometry rawButtonPading({
    double? horizontal,
    double? vertical,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? 35,
      vertical: vertical ?? 15,
    );
  }
}

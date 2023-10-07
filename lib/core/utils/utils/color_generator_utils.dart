import 'dart:math';
import 'package:flutter/material.dart';

class ColorGenerator {
  static Color randomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  static Color statusBackgroundColor(String status) {
    switch (status) {
      case "completed":
        return Colors.greenAccent.withOpacity(0.8);
      case "ongoing":
        return Colors.blueAccent.withOpacity(0.8);
      default:
        return Colors.redAccent.withOpacity(0.8);
    }
  }

  static Color contentRatingBackgroundColor(String status) {
    switch (status) {
      case "safe":
        return Colors.greenAccent.withOpacity(0.8);
      case "suggestive":
        return Colors.yellowAccent.withOpacity(0.8);
      default:
        return Colors.redAccent.withOpacity(0.8);
    }
  }
}

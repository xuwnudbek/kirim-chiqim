import 'package:flutter/material.dart';

extension WidgetGestureExtension on Widget {
  Widget onTap(Function() onTap) {
    return GestureDetector(
      onTap: onTap,
    );
  }
}

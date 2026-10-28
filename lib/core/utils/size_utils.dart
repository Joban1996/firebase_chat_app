import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get statusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;
  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;
}

extension PaddingExtension on Widget{
  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  // Add symmetric padding
  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  // Add custom padding to specific sides
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }

  // Set zero padding
  Widget get paddingZero {
    return Padding(
      padding: EdgeInsets.zero,
      child: this,
    );
  }
}

String capitalizeFirst(String cap){
  String updated = cap.replaceFirst(cap[0], cap[0].toUpperCase());
  return updated;
}
import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get statusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;
  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;
}
import 'package:flutter/material.dart';

extension ColorX on String {
  Color get converterColor => Color(int.parse(replaceAll("#", "0xff")));
}

extension AppContext on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;
  double get safeAreaHeight => screenHeight - statusBarHeight - bottomBarHeight;
  double get safeAreaWidth => screenWidth;

  double countHeightPhoto(
      {required int height, required int width, required crossAxisCount}) {
    return (height / width) * (screenSize.width / crossAxisCount);
  }
}

extension EnumX on Enum {
  String get nameString => name;
}

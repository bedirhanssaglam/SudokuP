import 'package:flutter/material.dart';
import '../constants/app/color_constants.dart';

@immutable
class BoardStyle {
  const BoardStyle._();

  static MaterialColor emptyColor(bool gameOver) =>
      gameOver ? ColorConstants.primaryColor : ColorConstants.secondaryColor;

  static Color buttonColor(int k, int i) {
    Color color;
    if (([0, 1, 2].contains(k) && [3, 4, 5].contains(i)) ||
        ([3, 4, 5].contains(k) && [0, 1, 2, 6, 7, 8].contains(i)) ||
        ([6, 7, 8].contains(k) && [3, 4, 5].contains(i))) {
      if (ColorConstants.primaryBackgroundColor == ColorConstants.darkGrey) {
        color = ColorConstants.grey;
      } else {
        color = Colors.grey[300]!;
      }
    } else {
      color = ColorConstants.primaryBackgroundColor;
    }

    return color;
  }

  static BorderRadiusGeometry buttonEdgeRadius(int k, int i) {
    if (k == 0 && i == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(5));
    } else if (k == 0 && i == 8) {
      return const BorderRadius.only(topRight: Radius.circular(5));
    } else if (k == 8 && i == 0) {
      return const BorderRadius.only(bottomLeft: Radius.circular(5));
    } else if (k == 8 && i == 8) {
      return const BorderRadius.only(bottomRight: Radius.circular(5));
    }
    return BorderRadius.circular(0);
  }
}

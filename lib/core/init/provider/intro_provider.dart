import 'package:flutter/material.dart';

class IntroProvider extends ChangeNotifier {
  int currentPage = 0;

  setCurrentPage(int val) {
    currentPage = val;
    notifyListeners();
  }
}

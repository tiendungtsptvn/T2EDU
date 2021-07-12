import 'package:flutter/cupertino.dart';

class AppIndex extends ChangeNotifier{
  AppIndex._internal();

  factory AppIndex.instance() {
    _instance ??= AppIndex._internal();
    return _instance;
  }

  static AppIndex _instance;

  int _index = 0;

  int get index => _index;

  void updateIndex(int index){
    _index = index;

    notifyListeners();
  }
}
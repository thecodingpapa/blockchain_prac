
import 'package:flutter/material.dart';

class IsFromSelected extends ChangeNotifier{
  bool value = true;

  void set(bool isFrom){
    this.value = isFrom;
    notifyListeners();
  }
}

IsFromSelected isFromSelected = IsFromSelected();
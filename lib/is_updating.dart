
import 'package:flutter/material.dart';

class IsUpdating extends ChangeNotifier{
  bool value = false;

  void set(bool isFrom){
    this.value = isFrom;
    notifyListeners();
  }
}

IsUpdating isUpdating = IsUpdating();
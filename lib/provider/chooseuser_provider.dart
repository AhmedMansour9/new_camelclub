
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/data/model/response/language_model.dart';
import 'package:new_camelclub/data/repository/language_repo.dart';

class ChooseUserProvider with ChangeNotifier {

  ChooseUserProvider();

  int _selectIndex = -1;

  int get selectIndex => _selectIndex;

  void setSelectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }


  }
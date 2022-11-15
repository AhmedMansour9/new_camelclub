import 'package:flutter/material.dart';
import 'package:new_camelclub/data/model/response/language_model.dart';
import 'package:new_camelclub/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}

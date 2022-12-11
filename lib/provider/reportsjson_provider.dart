import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_camelclub/data/model/response/reports_model.dart';
import 'package:new_camelclub/data/model/response/reportsjson_model.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/utill/strings.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/notifications_model.dart';
import '../data/model/response/response_model.dart';
import '../data/repository/category_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/api_checker.dart';


class ReportssProvider with ChangeNotifier {
  final CategoryRepo categoryRepo;
  final SharedPreferences sharedPreferences;

  ReportssProvider({required this.categoryRepo, required this.sharedPreferences});

  List<ReportsResult>? _reportsList;
  bool _isLoading =false;
  bool get isLoading => _isLoading;

  List<ReportsResult>? get reportsList => _reportsList;

  Future<void> getReportsList(BuildContext context, bool reload,String start,String end) async {
    _isLoading = true;
    notifyListeners();
    // if (_reportsList == null || reload) {

      ApiResponse apiResponse = await categoryRepo.getReportsList(start,end);
       if (apiResponse.response != null &&
           apiResponse.response?.statusCode == 200) {
         _reportsList = [];
         apiResponse.response?.data["result"].forEach(
                 (category) => _reportsList?.add(ReportsResult.fromJson(category)));

      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      _isLoading = false;
      notifyListeners();
    // }
  }



}
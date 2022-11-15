import 'package:flutter/material.dart';
import 'package:new_camelclub/data/model/response/base/api_response.dart';
import 'package:new_camelclub/data/model/response/config_model.dart';
import 'package:new_camelclub/data/repository/splash_repo.dart';
import 'package:new_camelclub/utill/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/base/custom_snackbar.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  final SharedPreferences sharedPreferences;

  SplashProvider({required this.splashRepo, required this.sharedPreferences});

  ConfigModel? _configModel;
  BaseUrls? _baseUrls;
  DateTime _currentTime = DateTime.now();

  ConfigModel? get configModel => _configModel;

  BaseUrls? get baseUrls => _baseUrls;

  DateTime get currentTime => _currentTime;

  Future<bool> initConfig(GlobalKey<ScaffoldMessengerState> globalKey) async {
    ApiResponse apiResponse = await splashRepo.getConfig();
    bool isSuccess;
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response?.data);
      _baseUrls = ConfigModel.fromJson(apiResponse.response?.data).baseUrls!;
      isSuccess = true;
      notifyListeners();
    } else {
      isSuccess = false;
      String _error;
      if (apiResponse.message is String) {
        _error = apiResponse.message;
      } else {
        _error = apiResponse.message.errors[0].message;
      }
      print(_error);
      // showCustomSnackBar(apiResponse.error.toString(),globalKey.currentState!.context);

    }
    return isSuccess;
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }

  bool isRestaurantClosed() {
    DateTime _open = DateFormat('hh:mm').parse(_configModel!.restaurantOpenTime!);
    DateTime _close =
        DateFormat('hh:mm').parse(_configModel!.restaurantCloseTime!);
    DateTime _openTime = DateTime(_currentTime.year, _currentTime.month,
        _currentTime.day, _open.hour, _open.minute);
    DateTime _closeTime = DateTime(_currentTime.year, _currentTime.month,
        _currentTime.day, _close.hour, _close.minute);
    if (_closeTime.isBefore(_openTime)) {
      _closeTime = _closeTime.add(Duration(days: 1));
    }
    if (_currentTime.isAfter(_openTime) && _currentTime.isBefore(_closeTime)) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> saveFirstVisit() async {
    try {
      await sharedPreferences.setBool(AppConstants.FIRST_TIME, true);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveFirstVisitOnBoarding() async {
    try {
      await sharedPreferences.setBool(AppConstants.FIRST_TIME_ONBOARDING, true);
    } catch (e) {
      throw e;
    }
  }

  bool isFirstVisitOnBoarding() {
    return sharedPreferences.containsKey(AppConstants.FIRST_TIME_ONBOARDING)
        ? true
        : false;
  }
  bool isFirstVisit() {
    return sharedPreferences.containsKey(AppConstants.FIRST_TIME)
        ? true
        : false;
  }
}

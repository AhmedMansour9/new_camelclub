import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/strings.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/notifications_model.dart';
import '../data/model/response/response_model.dart';
import '../data/repository/category_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/api_checker.dart';


class NotificationsProvider with ChangeNotifier {
  final CategoryRepo categoryRepo;
  final SharedPreferences sharedPreferences;

  NotificationsProvider({required this.categoryRepo, required this.sharedPreferences});

  List<NotificationsListModel>? _categoryList;
  bool _isLoading =false;
  bool get isLoading => _isLoading;

  int page = 1;
  int totalPage = 0;
  List<NotificationsListModel>? get categoryList => _categoryList;

  Future<void> getNotificationsList(BuildContext context,) async {
    page =1;
    _isLoading = true;
    notifyListeners();
      String id=sharedPreferences.getString('userId')!;
      ApiResponse apiResponse = await categoryRepo.getNotificationList(id,page.toString());
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        _categoryList = [];
        totalPage = apiResponse.response?.data["totalPages"];
        apiResponse.response?.data["result"].forEach(
                (category) => _categoryList?.add(NotificationsListModel.fromJson(category)));

      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      _isLoading = false;
      notifyListeners();
  }
  Future<void> getNotificationsListLoadMore(BuildContext context,) async {
    if(totalPage >= page) {
      page += 1;
      _isLoading = true;
      notifyListeners();
      String id = sharedPreferences.getString('userId')!;
      ApiResponse apiResponse = await categoryRepo.getNotificationList(
          id, page.toString());
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        // _categoryList = [];
        apiResponse.response?.data["result"].forEach(
                (category) =>
                _categoryList?.add(NotificationsListModel.fromJson(category)));
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      _isLoading = false;
      notifyListeners();
    }
  }

 String getStatus(String status,BuildContext context) {
    String TypeRequest="";
    if (status == "1" ) {
      TypeRequest = getTranslated('open_report', context);
    } else if (status == "2") {
      TypeRequest = getTranslated('underproccesor_report', context);
    } else if (status == "3" ) {
      TypeRequest = getTranslated('suspend_report', context);
    } else if (status == "5" ) {
      TypeRequest = getTranslated('canceled_report', context);
    } else if (status == "7" ) {
      TypeRequest = getTranslated('completed_report', context);
    }else if (status == "9" ) {
      TypeRequest = getTranslated('canceled_report', context);
    }
   return TypeRequest;
  }

  Color getColor(String status,BuildContext context){
    Color COLOR = Color(0xFF0b8764);
    if (status == "1" ) {
      COLOR = Color(0xFF0b8764);
    } else if (status == "2") {
      COLOR = Color(0xFF0b8764);
    } else if (status == "3" ) {
      COLOR = Color(0xff0bc691);
    } else if (status == "5" ) {
      COLOR = Color(0xffb40202);
    } else if (status == "7" ) {
      COLOR = ColorResources.COLOR_DARKPRIMARY;
    }

    return COLOR;
  }
  Future<ResponseModel> changeRequestStatus(String requestComplanitId,String complanitStatus,String? complanitHistoryId,String  notificationState,String notificationId) async {
    _isLoading = true;
    notifyListeners();

    // String userType=sharedPreferences.getString('userType')!;
    var map = <String, dynamic>{};
    map["requestComplanitId"] = requestComplanitId;
    map["complanitStatus"] = complanitStatus;
    map["complanitHistoryId"] = complanitHistoryId;
    map["notificationState"] = notificationState;
    map["notificationId"] = notificationId;
    ResponseModel responseModel;

    ApiResponse apiResponse = await categoryRepo.postReadNotification(
        map);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel(
        apiResponse.response?.data["statusEnum"].toString() == "savedSuccessfully"
            ? true
            : false,
        apiResponse.response?.data["message"],);
      // _verificationMsg = apiResponse.response?.data["message"];

      if (apiResponse.response?.data["statusEnum"].toString() == "success") {

      }

      // responseModel = ResponseModel(true, apiResponse.response?.data["message"]);
    } else {
      String errorMessage = "";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
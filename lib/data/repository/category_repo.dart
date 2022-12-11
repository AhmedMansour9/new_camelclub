import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_camelclub/data/datasource/remote/dio/dio_client.dart';
import 'package:new_camelclub/data/datasource/remote/exception/api_error_handler.dart';
import 'package:new_camelclub/data/model/response/SendReportRequestModel.dart';
import 'package:new_camelclub/data/model/response/base/api_response.dart';
import 'package:new_camelclub/utill/app_constants.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:new_camelclub/utill/strings.dart';
import 'package:path/path.dart';

import '../model/send_filtertion_model.dart';

class CategoryRepo {
  final DioClient dioClient;

  CategoryRepo({required this.dioClient});

  Future<ApiResponse> getCategoryList() async {
    try {
      final response = await dioClient.get(AppConstants.CATEGORY_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getNotificationList(
      String UserId, String pageNumber) async {
    var map = <String, dynamic>{};
    map["UserId"] = UserId;
    map["pageSize"] = "10";
    map["pageNumber"] = pageNumber;
    try {
      final response = await dioClient.get("${AppConstants.NOTIFICATIONS_URI}",
          queryParameters: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getReportsList(String start, String end) async {
    var map = <String, dynamic>{};
    map["formDate"] = start;
    map["toDate"] = end;
    try {
      final response =
          await dioClient.post("${AppConstants.REPORTSDATE_URI}", data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRegionsList() async {
    try {
      final response = await dioClient.get(AppConstants.CATEGORY_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSubCategoryList(String CatId) async {
    try {
      final response = await dioClient
          .get("${AppConstants.SUBCATEGORY_URI}?categoryComplanitId=$CatId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendUserToken(String token, String userId) async {
    try {
      var map = <String, dynamic>{};
      map["token"] = token;
      map["userId"] = userId;

      final response =
          await dioClient.post("${AppConstants.USER_TOKEN_URI}", data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> changeStatus(Map<String, dynamic> map) async {
    try {
      final response =
          await dioClient.post("${AppConstants.CHANGE_STATUS_URI}", data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> postReadNotification(Map<String, dynamic> map) async {
    try {
      final response = await dioClient
          .post("${AppConstants.POSTREADNOTIFICATION_URI}", data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> confirmcCodeStatus(Map<String, dynamic> map) async {
    try {
      final response = await dioClient
          .post("${AppConstants.VERIFYCODEREQUEST_URI}", data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendReportRequest(
      SendReportRequestModel sendReportRequestModel) async {
    try {
      final response = await dioClient.post("${AppConstants.SENDREPORT_URI}",
          data: sendReportRequestModel.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendFiltertionRequest(
      SendFiltertionRequestModel sendReportRequestModel) async {
    try {
      final response = await dioClient.post(
          "${AppConstants.SENDFiltertion_URI}",
          data: sendReportRequestModel.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> searchByCode(String code) async {
    try {
      final response =
          await dioClient.get("${AppConstants.SEARCHCODE_URI}?code=$code");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> updateProfile(File? file, String token) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${AppConstants.BASE_URL}${AppConstants.UPDATE_PROFILE_URI}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    if (file != null) {
      print(
          '----------------${file.readAsBytes().asStream()}/${file.lengthSync()}/${file.path.split('/').last}');
      request.files.add(http.MultipartFile(
          'file', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split('/').last));
    }
    // else if(data != null) {
    //   Uint8List _list = await data.readAsBytes();
    //   var part = http.MultipartFile('image', data.readAsBytes().asStream(), _list.length, filename: basename(data.path), contentType: MediaType('image', 'jpg'));
    //   request.files.add(part);
    //   // print('----------------${_list.length}/${basename(data.path)}');
    // }

    // request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }
}

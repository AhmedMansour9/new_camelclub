import 'package:flutter/material.dart';
import 'package:new_camelclub/data/model/response/base/api_response.dart';
import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class ApiChecker {
  static Future<void> checkApi(
      BuildContext context, ApiResponse apiResponse) async {
    if (apiResponse.message is! String &&
        apiResponse.message.errors[0].message == 'Unauthenticated.') {
      Provider.of<SplashProvider>(context, listen: false).removeSharedData();
      // Navigator.pushNamedAndRemoveUntil(context, Routes.getLoginRoute(), (route) => false);
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.getSignUpRoute(), (route) => false);
    } else {
      String _errorMessage;
      if (apiResponse.message is String) {
        _errorMessage = apiResponse.message.toString();
      } else {
        _errorMessage = apiResponse.message.errors[0].message;
      }
      print(_errorMessage);
      await Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        messageColor: Colors.white,
        message: _errorMessage,
        duration: Duration(seconds: 3),
      ).show(context);

    }
  }
}

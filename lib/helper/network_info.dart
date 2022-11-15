import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';

import '../view/base/custom_snackbar.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult _result = await connectivity.checkConnectivity();
    return _result != ConnectivityResult.none;
  }

  static void checkConnectivity(GlobalKey<ScaffoldMessengerState> globalKey) {
    bool _firstTime = true;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : globalKey.currentState?.hideCurrentSnackBar();
        // globalKey.currentState?.showSnackBar(
            showCustomSnackBar( isNotConnected ? getTranslated('no_connection', globalKey.currentContext!) :
        getTranslated('connected', globalKey.currentContext!), globalKey.currentContext!);



        //   SnackBar(
        //   backgroundColor: isNotConnected ? Colors.red : Colors.green,
        //   duration: Duration(seconds: isNotConnected ? 6000 : 3),
        //   content: Text(
        //    ,
        //     textAlign: TextAlign.center,
        //   ),
        // ));
      }
      _firstTime = false;
    });
  }

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 3000));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

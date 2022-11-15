import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/helper/version-check.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/localization_provider.dart';
import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:new_camelclub/utill/app_constants.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/images.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/custom_snackbar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    if (!Provider.of<SplashProvider>(context, listen: false).isFirstVisit())
      Provider.of<LocalizationProvider>(context, listen: false)
          .setLanguage(Locale(
        "ar",
        "SA",
      ));
    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? SizedBox()
            : _globalKey.currentState?.hideCurrentSnackBar();
        showCustomSnackBar( isNotConnected ? getTranslated('no_connection', context) :
        getTranslated('connected',context), context);

        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Provider.of<SplashProvider>(context, listen: false).initSharedData();

    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {

            Timer(Duration(seconds: 3), () async {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.getLanguageRoute("1"),
                      (route) => false);

              // if (Provider.of<AuthProvider>(context, listen: false)
              //     .isLoggedIn()) {
              //   Provider.of<AuthProvider>(context, listen: false).updateToken();
              //   await Provider.of<WishListProvider>(context, listen: false)
              //       .initWishList(context);
              //   Navigator.pushNamedAndRemoveUntil(
              //       context, Routes.getMainRoute(), (route) => false);
              // } else {
              //   Navigator.pushNamedAndRemoveUntil(
              //       context,
              //       !Provider.of<SplashProvider>(context, listen: false)
              //               .isFirstVisitOnBoarding()
              //           ? Routes.getOnBoardingRoute()
              //           : Routes.getLanguageRoute("1"),
              //       (route) => false);
              // }
            }
            );

  }

  @override
  Widget build(BuildContext context) {

    // String languageCode = Localizations.localeOf(context).languageCode;
    // print('ssssssss + $languageCode');
    return ScaffoldMessenger(
      key: _globalKey,

      child: Scaffold(
        //key: _globalKey,
        backgroundColor: ColorResources.COLOR_DARKPRIMARY,
        body: Center(
          child: Consumer<SplashProvider>(builder: (context, splash, child) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                child: Image.asset(Images.logo,fit: BoxFit.cover,),
              ),
            );
          }
          ),
        ),
      ),
    );
  }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/view/screens/auth/login_screen.dart';
import 'package:new_camelclub/view/screens/auth/register_screen.dart';
import 'package:new_camelclub/view/screens/chooseuser/choose_user_screen.dart';
import 'package:new_camelclub/view/screens/language/choose_language_screen.dart';
import 'package:new_camelclub/view/screens/not_found.dart';

import 'package:new_camelclub/view/screens/splash/splash_screen.dart';

import '../view/screens/auth/verfication_code.dart';


class RouterHelper {
  static final FluroRouter router = FluroRouter();

//*******Handlers*********
  static Handler _splashHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => SplashScreen());
  static Handler _chooseUserHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => ChooseUserScreen());
  static Handler _loginUserHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  static Handler _registerUserHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => RegisterScreen());
  static Handler _notFoundHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => NotFound());
  static Handler _languageHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return ChooseLanguageScreen(fromMenu: params['page'][0] == 'menu');
  });

  static Handler _verificationHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) {
    VerificationScreen? _verificationScreen = ModalRoute.of(context!)?.settings.arguments as VerificationScreen?;
    return _verificationScreen != null ? _verificationScreen : VerificationScreen(
      fromSignUp: params['page'][0] == 'sign-up', phone: params['phone'][0],userId: params['userId'][0] ,
    );
  });


//*******Route Define*********
  static void setupRouter() {
    router.notFoundHandler = _notFoundHandler;
    router.define(Routes.SPLASH_SCREEN, handler: _splashHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LANGUAGE_SCREEN, handler: _languageHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.CHOOSEUSER_SCREEN, handler: _chooseUserHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LOGINUSER_SCREEN, handler: _loginUserHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.REGISTERUSER_SCREEN, handler: _registerUserHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.VERIFY, handler: _verificationHandler, transitionType: TransitionType.fadeIn);

  }
}
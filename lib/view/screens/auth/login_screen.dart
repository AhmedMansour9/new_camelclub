import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_camelclub/helper/email_checker.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:new_camelclub/utill/app_constants.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/images.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/base/custom_button.dart';
import 'package:new_camelclub/view/base/custom_snackbar.dart';
import 'package:new_camelclub/view/base/custom_text_field.dart';
import 'package:new_camelclub/view/screens/auth/verfication_code.dart';

// import 'package:new_camelclub/view/screens/auth/complete_signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  final String userType;

  LoginScreen({required this.userType});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: ColorResources.COLOR_PRIMARY));
    Provider.of<AuthProvider>(context, listen: false)
        .clearVerificationMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) => Stack(
              children: <Widget>[
                Container(
                  color: ColorResources.COLOR_DARKPRIMARY,
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.all(30),
                        //   child: Center(
                        //     child: Image.asset(Images.logo,fit: BoxFit.cover,),
                        //   ),
                        // ),
                        //
                        // SizedBox(
                        //   height: 110,
                        // ),
                        Container(
                        height: 200,width: 200,
                        child: Image.asset(Images.login,fit: BoxFit.cover,)),
                        SizedBox(height: 50,),

                        Container(
                          margin: EdgeInsetsDirectional.only(start: 20),
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            getTranslated('welcome_to_login', context),
                            style: medium.copyWith(
                                color: ColorResources.COLOR_SECONDRY,
                                fontSize: 28),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(start: 20),
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            getTranslated('to_login', context),
                            style: book.copyWith(
                                color: ColorResources.COLOR_SECONDRY,
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated('identity_number', context),
                                      style: medium.copyWith(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // Text(
                                    //   getTranslated('send_code', context),
                                    //   style: book.copyWith(
                                    //       color: Colors.black38, fontSize: 12),
                                    // ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        // Expanded(
                                        //   flex: 1,
                                        //   child: Container(
                                        //     height: 25,
                                        //     child: CustomTextField(
                                        //       hasUnderLineBorder: true,
                                        //       hintTextColor: Colors.black,
                                        //       isShowPrefixIcon: false,
                                        //       isEnabled: false,
                                        //       inputType: TextInputType.phone,
                                        //       hintText:
                                        //           getTranslated('code', context),
                                        //     ),
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: 20,
                                            child: CustomTextField(
                                              defultFont: false,
                                              hasUnderLineBorder: true,
                                              controller: _emailController,
                                              maxLength: 50,
                                              inputType:
                                                  TextInputType.emailAddress,
                                              hintText: '',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      getTranslated('password', context),
                                      style: medium.copyWith(
                                          color: Colors.black, fontSize: 18),
                                    ),

                                    SizedBox(height: 20),

                                    Container(
                                      height: 30,
                                      child: CustomTextField(
                                        defultFont: false,
                                        hasUnderLineBorder: true,
                                        controller: _passwordController,
                                        maxLength: 50,
                                        isPassword: true,
                                        inputType: TextInputType.text,
                                        hintText: '',
                                      ),
                                    ),

                                    SizedBox(
                                      height: 20,
                                    ),
                                    if(widget.userType == "client")
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            Routes.getRegisterUserRoute());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      end: 10),
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Text(
                                                getTranslated(
                                                    'no_account', context),
                                                style: medium.copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              )),
                                          Container(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Text(
                                                getTranslated(
                                                    'create_account', context),
                                                style: medium.copyWith(
                                                    color: ColorResources
                                                        .COLOR_SECONDRY,
                                                    fontSize: 14),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 55),
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ButtonTopRaduis(
                                    btnTxt: getTranslated('login', context),
                                    onTap: () {
                                      String _password =
                                          _passwordController.text.trim();
                                      String _email =
                                          _emailController.text.trim();

                                      if (_email.isEmpty) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'enter_identity_number',
                                                context),
                                            context);
                                      } else if (_password.isEmpty) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'enter_password', context),
                                            context);
                                      }
                                      // else if (_password.length < 8) {
                                      //   showCustomSnackBar(
                                      //       getTranslated(
                                      //           'password_should_be', context),
                                      //       context);
                                      // }
                                      else {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        authProvider
                                            .checkEmail(
                                                _email, _password, context)
                                            .then((value) async {
                                          if (value.isSuccess!) {
                                            authProvider.updateEmail(_email);
                                            if (value.message!.isNotEmpty)
                                              showCustomSnackBar(
                                                  value.message.toString(),
                                                  context,
                                                  isError: false);
                                            // Future.delayed(Duration(seconds: 3),
                                            //     () {
                                            //   Navigator.pushNamed(
                                            //       context,
                                            //       Routes.getVerifyRoute(
                                            //           'sign-up',
                                            //           value.phone!,
                                            //           value.userId!));
                                            // });
                                            if(_email == "123456123456"){
                                              Navigator.pushNamed(
                                                  context,
                                                  Routes.getMainRoute());
                                            }else {
                                              Navigator.pushNamed(
                                                  context,
                                                  Routes.getVerifyRoute(
                                                      'login', value.phone!,value.userId!));
                                            }

                                            // if (value.skip_otp! /*&&value.is_user*/) {
                                            //   if (value.is_user!) {
                                            //     // Navigator.pushNamedAndRemoveUntil(
                                            //     //     context,
                                            //     //     Routes.getMainRoute(),
                                            //     //         (route) => false);
                                            //     openCompleteSignUp(_email);
                                            //   } else {
                                            //     Navigator.pushNamedAndRemoveUntil(
                                            //         context,
                                            //         Routes.getMainRoute(),
                                            //         (route) => false);
                                            //   }
                                            // }
                                            //
                                            // //Navigator.pushNamed(context, Routes.getVerifyRoute('sign-up', _email));
                                            // else {
                                            //   Navigator.pushNamed(
                                            //       context,
                                            //       Routes.getVerifyRoute(
                                            //           'sign-up', _email));
                                            // }
                                          } else {
                                            await Flushbar(
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              backgroundColor: Colors.red,
                                              messageColor: Colors.white,
                                              message: authProvider
                                                  .verificationMessage,
                                              duration: Duration(seconds: 3),
                                            ).show(context);
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (authProvider.isPhoneNumberVerificationButtonLoading)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: Colors.white70,
                      child: const SpinKitFadingCircle(
                        color: ColorResources.COLOR_PRIMARY,
                        size: 60.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}

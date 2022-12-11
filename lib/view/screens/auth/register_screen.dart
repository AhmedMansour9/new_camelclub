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

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _identityNUmberController = TextEditingController();
  TextEditingController _roomNumberController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();

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
                      mainAxisSize: MainAxisSize.min,
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
                        // Container(
                        //   margin: EdgeInsetsDirectional.only(start: 20),
                        //   alignment: AlignmentDirectional.bottomStart,
                        //   child: Text(
                        //     getTranslated('to_login', context),
                        //     style: book.copyWith(
                        //         color: ColorResources.COLOR_SECONDRY,
                        //         fontSize: 13),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
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
                                      getTranslated('full_name', context),
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
                                              controller: _fullNameController,
                                              maxLength: 50,
                                              isLetters: true,
                                              inputType: TextInputType.emailAddress,
                                              hintText: '',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 30,
                                    // ),

                                    // Text(
                                    //   getTranslated('room_number', context),
                                    //   style: medium.copyWith(
                                    //       color: Colors.black, fontSize: 18),
                                    // ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Text(
                                    //   getTranslated('send_code', context),
                                    //   style: book.copyWith(
                                    //       color: Colors.black38, fontSize: 12),
                                    // ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    Row(
                                      children: const [
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
                                        // Expanded(
                                        //   flex: 4,
                                        //   child: Container(
                                        //     height: 20,
                                        //     child: CustomTextField(
                                        //       defultFont: false,
                                        //       hasUnderLineBorder: true,
                                        //       controller: _roomNumberController,
                                        //       maxLength: 50,
                                        //       inputType:
                                        //       TextInputType.number,
                                        //       hintText: '',
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),

                                    Text(
                                      getTranslated('phone_number', context),
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
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 20,
                                            child: CustomTextField(
                                              hasUnderLineBorder: true,
                                              hintTextColor: Colors.black,
                                              isShowPrefixIcon: false,
                                              isEnabled: false,
                                              inputType: TextInputType.number,
                                              hintText:
                                                  getTranslated('code', context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: 20,
                                              child: CustomTextField(
                                                defultFont: false,
                                                hasUnderLineBorder: true,
                                                controller: _phoneController,
                                                maxLength: 50,
                                                inputType:
                                                TextInputType.number,
                                                hintText: '',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),

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
                                              controller: _identityNUmberController,
                                              maxLength: 50,
                                              inputType:
                                              TextInputType.number,
                                              hintText: '',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
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


                                  ],
                                ),
                              ),
                              SizedBox(height: 35),
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ButtonTopRaduis(
                                    btnTxt: getTranslated('create_account', context),
                                    onTap: () {
                                      String _fullName =
                                      _fullNameController.text.trim();
                                      // String _roomNumber =
                                      // _roomNumberController.text.trim();
                                      String _password =
                                      _passwordController.text.trim();
                                      String _phone =
                                      _phoneController.text.trim();
                                      String _identityNumber =
                                      _identityNUmberController.text.trim();
                                      if (_fullName.isEmpty) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'enter_full_name',
                                                context),
                                            context);
                                      }
                                     // else if (_roomNumber.isEmpty) {
                                     //    showCustomSnackBar(
                                     //        getTranslated(
                                     //            'enter_room_number', context),
                                     //        context);
                                     //  }
                                     else if (_phone.isEmpty) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'enter_phone_number', context),
                                            context);
                                      }
                                     else if (_phone.length < 8) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'phone_should_be', context),
                                            context);
                                      }

                                    else  if (_identityNumber.isEmpty) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'enter_identity_number',
                                                context),
                                            context);
                                      }

                                    else if (_password.isEmpty) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'enter_password', context),
                                            context);
                                      } else if (_password.length < 8) {
                                        showCustomSnackBar(
                                            getTranslated(
                                                'password_should_be', context),
                                            context);
                                      } else {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        authProvider
                                            .requestRegister(_fullName,_phone,_identityNumber, _password,context)
                                            .then((value) async {
                                          if (value.isSuccess!) {
                                            authProvider.updateEmail(_phone);
                                            if (value.message!.isNotEmpty)
                                              showCustomSnackBar(
                                                  value.message.toString(),
                                                  context);
                                            Navigator.pushNamed(
                                                context,
                                                Routes.getVerifyRoute(
                                                    'sign-up', value.phone!,value.userId!));
                                            // Future.delayed(Duration(seconds: 3), () {
                                            //
                                            // });


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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/images.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/strings.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/base/custom_app_bar.dart';
import 'package:new_camelclub/view/base/custom_button.dart';
import 'package:new_camelclub/view/base/custom_snackbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

//
class VerificationScreen extends StatefulWidget {
  final String phone;
  final String userId;
  final bool fromSignUp;
  VerificationScreen({required this.phone, this.fromSignUp = false,required this.userId });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: ColorResources.COLOR_SECONDRY));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(context: context, title: "",isBackButtonExist: true,),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Center(
                    child: Image.asset(
                      Images.verify,
                      width: 142,
                      height: 142,
                    ),
                  ),
                  SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                        child: Text(
                          '${getTranslated('please_enter_4_digit_code', context)}',
                          textAlign: TextAlign.center,
                          style: medium.copyWith(color: Colors.black , fontSize: 18  ,height: 1.5),
                        )),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                        child: Text(
                          '${widget.phone}',
                          textAlign: TextAlign.center,
                          style: book.copyWith(color: Colors.black , fontSize: 15 ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 35),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        enablePinAutofill: true,
                        length: 4,
                        appContext: context,
                        obscureText: false,


                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 50,
                          fieldWidth: 50,
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(55),
                          selectedColor: ColorResources.colorMap[600],
                          selectedFillColor: Colors.white,
                          inactiveFillColor: Colors.white30,
                          inactiveColor: Colors.black26,
                          activeColor: Colors.white,
                          activeFillColor: ColorResources.getSearchBg(context),
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        onChanged: authProvider.updateVerificationCode,
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       getTranslated('i_didnt_receive_the_code', context),
                  //       style: medium.copyWith(
                  //         fontSize: 15,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         // if(fromSignUp) {
                  //         //   Provider.of<AuthProvider>(context, listen: false).checkEmail(phone).then((value) {
                  //         //     if (value.isSuccess!) {
                  //         //       showCustomSnackBar('Resent code successful', context, isError: false);
                  //         //     } else {
                  //         //       showCustomSnackBar(value.message!, context);
                  //         //     }
                  //         //   });
                  //         // }else {
                  //         //   Provider.of<AuthProvider>(context, listen: false).forgetPassword(phone).then((value) {
                  //         //     if (value.isSuccess!) {
                  //         //       showCustomSnackBar('Resent code successful', context, isError: false);
                  //         //     } else {
                  //         //       showCustomSnackBar(value.message!, context);
                  //         //     }
                  //         //   });
                  //         // }
                  //       },
                  //       child: Padding(
                  //         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //         child: Text(
                  //           getTranslated('resend_code', context),
                  //           style: medium.copyWith(
                  //             fontSize: 16,
                  //             color: ColorResources.COLOR_PRIMARY,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: 80),
                  authProvider.isEnableVerificationCode ? !authProvider.isPhoneNumberVerificationButtonLoading
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal:40),
                    child: CustomButton(
                      btnTxt: getTranslated('verify', context),
                      onTap: () {
                        // if(fromSignUp) {
                        //   Provider.of<AuthProvider>(context, listen: false).verifyEmail(phone).then((value) async {
                        //     if(value.isSuccess!) {
                        //       if(value.is_user!){
                        //         print('new user');
                        //         // Navigator.pushNamed(context, Routes.getCreateAccountRoute(phone));
                        //         Navigator.of(context).pop();
                        //         openCompleteSignUp(phone,context);
                        //       }else{
                        //         await Provider.of<WishListProvider>(context, listen: false).initWishList(context);
                        //         if(ResponsiveHelper.isWeb()) {
                        //           Navigator.pushReplacementNamed(context, Routes.getMainRoute());
                        //         }else {
                        //           Navigator.pushNamedAndRemoveUntil(context, Routes.getMainRoute(), (route) => false);
                        //         }
                        //       }
                        //     }else {
                        //       showCustomSnackBar(value.message!, context);
                        //     }
                        //   });
                        // }else {
                          Provider.of<AuthProvider>(context, listen: false).verifyToken(widget.userId,context,widget.fromSignUp).then((value) {
                            if(value.isSuccess!) {
                              String userType=authProvider.getUserType();
                              if(userType == "client"){
                                Navigator.pushNamedAndRemoveUntil(context, Routes.getMainCLientRoute(),(route) => false);

                              }else {
                                Navigator.pushNamedAndRemoveUntil(context, Routes.getMainRoute(),(route) => false);
                              }
                            }else {
                              showCustomSnackBar(value.message!, context);
                            }
                          });
                        // }
                      },
                    ),
                  ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );


  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/home_provider.dart';

import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/images.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/base/custom_button.dart';
import 'package:new_camelclub/view/base/main_app_bar.dart';
import 'package:new_camelclub/view/screens/auth/sign_out_confirmation_dialog.dart';

import 'package:provider/provider.dart';

class SubCategoryScreen extends StatefulWidget {

  final String catId;
  final String catName;
  SubCategoryScreen({required this.catId,required this.catName});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: ColorResources.COLOR_PRIMARY));

    // Provider.of<HomeProvider>(context, listen: false)
    //     .getSubCategoryList(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.red,
          body: Consumer<HomeProvider>(
              builder: (context, homeProvider, child) => Stack(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      start: 20,
                      top: 40,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: ColorResources.COLOR_DARKPRIMARY,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.catName}',
                          style: medium.copyWith(
                              fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius:
                          BorderRadius.all(Radius.circular(30.0))),
                      margin: EdgeInsets.only(top: 100),
                      padding:
                      EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: GridView.builder(

                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,  childAspectRatio: 1.1,
                        ),
                        itemCount: homeProvider.categoryList!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // padding: EdgeInsets.only(
                        //     top: Dimensions.PADDING_SIZE_LARGE),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 200,
                            child: Center(child: Text(homeProvider.categoryList![index].nameAr ?? '',style: TextStyle(color: Colors.black,fontSize: 18),)),
                            margin: EdgeInsets.all(13),
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: ColorResources.COLOR_DARKPRIMARY, spreadRadius: 3),
                              ],
                            ),
                          );
                        },
                      ))
                ],
              ))),
    );
  }

  logout(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SignOutConfirmationDialog());
  }
}

// Center(
// child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
// SizedBox(height: MediaQuery.of(context).padding.top),
// Container(
//   height: 80, width: 80,
//   decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ColorResources.COLOR_WHITE, width: 2)),
//   child: ClipOval(
//     child: _isLoggedIn ? FadeInImage.assetNetwork(
//       placeholder: Images.placeholder_user, height: 80, width: 80, fit: BoxFit.cover,
//       image: '${Provider.of<SplashProvider>(context,).baseUrls.customerImageUrl}/'
//           '${profileProvider.userInfoModel != null ? profileProvider.userInfoModel.image : ''}',
//       imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_user, height: 80, width: 80, fit: BoxFit.cover),
//     ) : Image.asset(Images.placeholder_user, height: 80, width: 80, fit: BoxFit.cover),
//   ),
// ),
// Column(children: [
//   SizedBox(height: 20),
//   _isLoggedIn ? profileProvider.userInfoModel != null ? Text(
//     '${profileProvider.userInfoModel.fName ?? ''} ${profileProvider.userInfoModel.lName ?? ''}',
//     style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.COLOR_WHITE),
//   ) : Container(height: 15, width: 150, color: Colors.white) : Text(
//     getTranslated('guest', context),
//     style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.COLOR_WHITE),
//   ),
//   SizedBox(height: 10),
//   _isLoggedIn ? profileProvider.userInfoModel != null ? Text(
//     '${profileProvider.userInfoModel.phone ?? ''}',
//     style: rubikRegular.copyWith(color: ColorResources.BACKGROUND_COLOR),
//   ) : Container(height: 15, width: 100, color: Colors.white) : Text(
//     '',
//     style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.COLOR_WHITE),
//   ),
//   SizedBox(height: 10),
//   _isLoggedIn ? profileProvider.userInfoModel != null ? Text(
//     '${getTranslated('bbalance', context)}: ${Provider.of<OrderProvider>(context, listen: true).balance.toString()}',
//     style: rubikRegular.copyWith(color: ColorResources.BACKGROUND_COLOR),
//   ) : Container(height: 15, width: 100, color: Colors.white) : SizedBox(),
// ]),
// ]),
// ),

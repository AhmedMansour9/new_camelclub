import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_camelclub/data/model/response/language_model.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/chooseuser_provider.dart';
import 'package:new_camelclub/provider/language_provider.dart';
import 'package:new_camelclub/provider/localization_provider.dart';
import 'package:new_camelclub/utill/app_constants.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/images.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/strings.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/base/custom_button.dart';
import 'package:new_camelclub/view/base/custom_snackbar.dart';
// import 'package:new_camelclub/view/base/main_app_bar.dart';
import 'package:new_camelclub/view/screens/language/widget/search_widget.dart';
import 'package:provider/provider.dart';

class ChooseUserScreen extends StatelessWidget {
  final bool fromMenu;

  ChooseUserScreen({this.fromMenu = false});

  @override
  Widget build(BuildContext context) {
    // Provider.of<ChooseUserProvider>(context, listen: false)
    //     .initializeAllLanguages(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: ColorResources.COLOR_PRIMARY));

    return Scaffold(

        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                color: ColorResources.COLOR_DARKPRIMARY,
              ),

              Container(
                alignment: AlignmentDirectional.bottomStart,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //   margin: EdgeInsetsDirectional.only(start: 20),
                    //   alignment: AlignmentDirectional.bottomStart,
                    //   child: Text(
                    //     getTranslated('welcome', context),
                    //     style: medium.copyWith(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 40),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(
                        child: Image.asset(Images.logo,fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(
                      height: 185,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            getTranslated('type_user', context),
                            style: rubikBold.copyWith(
                                color: Colors.black, fontSize: 23),
                          ),
                          SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.getLoginUserRoute(),
                                  (route) => false);

                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                              color:Colors.white ,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: ExactAssetImage(Images.user),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(
                                  getTranslated('people_login', context) ,
                                  style: book.copyWith(
                                      fontSize: 14,
                                      color:  Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ),
                          SizedBox(height: 5,),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.getLoginUserRoute(),
                                      (route) => false);
                            },
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                  color:Colors.white ,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: ExactAssetImage(Images.staff),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      getTranslated('staff_login', context) ,
                                      style: book.copyWith(
                                          fontSize: 14,
                                          color:  Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }


}

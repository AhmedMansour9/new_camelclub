import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/notifications_provider.dart';
import '../../../provider/reportsjson_provider.dart';
import '../../../utill/color_resources.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utill/images.dart';
import '../auth/sign_out_confirmation_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_SECONDRY,
          centerTitle: true,
          title: Text(getTranslated('menu', context)),
        ),
        body: Consumer<AuthProvider>(
    builder: (context, authProvider, child) => Column(
          children: [
            Container(
                margin: EdgeInsets.all(20),
                child: Image.asset(Images.logo,fit: BoxFit.cover,)),
            SizedBox(height: 50,),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(
                  horizontal: 15),
              child: Row(
                children: [
                  Text(
                      '${getTranslated('identity_number', context)} : '),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        .6,
                    child: Text(
                        authProvider.getIdNUmber(),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: medium.copyWith(
                            fontSize: 14,
                            color: ColorResources
                                .COLOR_GREY)),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(
                  horizontal: 15),
              child: Row(
                children: [
                  Text(
                      '${getTranslated('phone_number', context)} : '),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        .6,
                    child: Text(authProvider.getPhone(),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: medium.copyWith(
                            fontSize: 14,
                            color: ColorResources
                                .COLOR_GREY)),
                  )
                ],
              ),
            ),
            SizedBox(height: 150,),
            InkWell(
              onTap: (){
                logout(context);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(

                    color: ColorResources.COLOR_PRIMARY,
                    borderRadius:
                    BorderRadius.all( Radius.circular(25))),
                child: Center(
                  child: Text(getTranslated('logout', context),style: medium.copyWith(fontSize: 16,color: Colors.black),),
                ),
              ),
            ),
          ],
        )
        )
    );
  }

  logout(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SignOutConfirmationDialog());
  }
}

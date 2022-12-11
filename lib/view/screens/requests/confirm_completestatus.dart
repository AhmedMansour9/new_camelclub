import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/strings.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:provider/provider.dart';

import '../../../provider/home_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ConfirmCompleteStatusDialog extends StatefulWidget {
  final String status;
  final String requestId;
  ConfirmCompleteStatusDialog({required this.status,required this.requestId});

  @override
  State<ConfirmCompleteStatusDialog> createState() => _ConfirmCompleteStatusDialogState();
}

class _ConfirmCompleteStatusDialogState extends State<ConfirmCompleteStatusDialog> {
  late File? file = null;
  late PickedFile? data = null;
  final picker = ImagePicker();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child:  Consumer<HomeProvider>(
            builder: (context,homeProvider,child)=>  !homeProvider.isLoadingDetails ? Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${getTranslated('confirm_code', context)}',
                  style:
                  medium.copyWith(fontSize: 15, color: Colors.black),
                ),
                SizedBox(height: 15,),

                Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                      BorderRadius.all(Radius.circular(15.0))),
                  margin: EdgeInsets.only(
                      top: 15, right: 15, left: 15, bottom: 25),
                  child: CustomTextField(
                    defultFont: false,
                    fillColor: Colors.transparent,
                    hasUnderLineBorder: true,
                    controller: _descriptionController,
                    maxLength: 4,
                    maxLines: 5,
                    isPassword: false,
                    inputType: TextInputType.number,
                    hintText: '',
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color:
                            ColorResources.COLOR_DARKPRIMARY,
                            spreadRadius: 1),
                      ],
                      borderRadius: BorderRadius.all(
                          Radius.circular(20.0))),
                  alignment: AlignmentDirectional.bottomEnd,
                  margin: EdgeInsets.only(
                      right: 35, left: 35, bottom: 20),
                  width: 120,
                  height: 40,
                  child: CustomButton(
                    btnTxt:
                    getTranslated('confirm', context),
                    onTap: () async {
                      if(_descriptionController.text.isNotEmpty) {
                        changeStatus(
                            homeProvider,
                            widget.status,
                            widget.requestId
                                .toString(),
                            _descriptionController.text.toString());
                      }else{
                        showCustomSnackBar(getTranslated('valid_empty', context), isError: false, context);
                      }
                    },
                  ),
                ),
              ],
            ): Container(
              height: 200,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.white70,
                  child: const SpinKitFadingCircle(
                    color: ColorResources.COLOR_PRIMARY,
                    size: 60.0,
                  ),
                ),
              ),
            )
        )
    );
  }

  void _choose(HomeProvider homeProvider) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        homeProvider.updateUserInfo(file,
            Provider.of<AuthProvider>(context, listen: false).getUserToken());
      } else {
        print('No image selected.');
      }
    });
  }

  void changeStatus(HomeProvider homeProvider, String status, String requestId,String code ) {
    homeProvider
        .confirmcodeStatus(requestId,code, status)
        .then((value) {
      if (value.isSuccess!) {
        showCustomSnackBar(getTranslated('suuces_completed', context), isError: false, context)
            .then((value) {
          homeProvider.sendDataFiltertion();
          Navigator.of(context).pop();
        });

      }
    });
  }

}

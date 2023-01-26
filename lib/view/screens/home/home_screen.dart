import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/home_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/images.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/base/custom_button.dart';
import 'package:new_camelclub/view/screens/auth/sign_out_confirmation_dialog.dart';
import 'package:new_camelclub/view/screens/home/dialog_fullscreen_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/routes.dart';
import '../../base/custom_text_field.dart';
import 'complete_report_dialog.dart';
import 'package:another_flushbar/flushbar.dart';

class HomeScreen extends StatefulWidget {
  final Function? onTap;

  HomeScreen({this.onTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool value = false;
  TextEditingController _descriptionController = TextEditingController();
  late File? file = null;
  late PickedFile? data = null;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: ColorResources.COLOR_PRIMARY));

    Provider.of<HomeProvider>(context, listen: false)
        .getCategoryList(context, true);
    // Provider.of<HomeProvider>(context, listen: false)
    //     .getRegionsList();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<HomeProvider>(
              builder: (context, homeProvider, child) => Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsetsDirectional.only(
                                start: 20,
                                top: 40,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 95,
                              color: ColorResources.COLOR_DARKPRIMARY,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${getTranslated('choose_service', context)}',
                                    style: medium.copyWith(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => logout(context),
                              child: Container(
                                padding: EdgeInsetsDirectional.only(
                                  start: 20,
                                  top: 35,
                                ),
                                child: Image.asset(Images.log_out,
                                    width: 25, height: 25, color: Colors.black),
                              ),
                            ),
                            Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Color(0xffffff),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0.0))),
                                margin: EdgeInsets.only(
                                    top: 115, right: 10, left: 10),
                                padding:
                                    EdgeInsets.only(top: 0, right: 0, left: 0),
                                child: ListView.builder(
                                  itemCount:
                                      homeProvider.categoryList?.length ?? 0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  // physics: NeverScrollableScrollPhysics(),
                                  // padding: EdgeInsets.only(
                                  //     top: Dimensions.PADDING_SIZE_LARGE),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => openSubCategory(
                                          context, homeProvider, index),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 5),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 15),
                                        child: Center(
                                            child: Text(
                                          homeProvider.getTitleCategory(index),
                                          style: TextStyle(
                                              color: homeProvider
                                                          .categoryPoistion ==
                                                      index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16),
                                        )),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: homeProvider
                                                      .categoryPoistion ==
                                                  index
                                              ? ColorResources.COLOR_SECONDRY
                                              : Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: ColorResources
                                                    .COLOR_DARKPRIMARY,
                                                spreadRadius: 1),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )),
                            !homeProvider.isLoading
                                ? Container(
                                    // height: MediaQuery.of(context).size.height * .4,
                                    decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0.0))),
                                    margin: EdgeInsets.only(top: 200),
                                    padding: EdgeInsets.only(
                                        top: 0, right: 0, left: 0),
                                    child: ListView.builder(
                                      itemCount: homeProvider
                                              .subCategoryList?.length ??
                                          0,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: BouncingScrollPhysics(),
                                      // physics: NeverScrollableScrollPhysics(),
                                      // padding: EdgeInsets.only(
                                      //     top: Dimensions.PADDING_SIZE_LARGE),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () => {},
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: ColorResources
                                                        .COLOR_DARKPRIMARY,
                                                    spreadRadius: 1),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: ColorResources
                                                      .COLOR_SECONDRY,
                                                  checkColor: Colors.white,
                                                  value: homeProvider
                                                      .checkIdInList(
                                                          homeProvider
                                                              .subCategoryList![
                                                                  index]
                                                              .id
                                                              .toString()),
                                                  // onChanged: null,
                                                  // value: this.value,
                                                  onChanged: (bool? value) {
                                                    homeProvider.saveCheckId(
                                                        context,
                                                        value!,
                                                        homeProvider
                                                            .subCategoryList![
                                                                index]
                                                            .id
                                                            .toString(),
                                                        homeProvider
                                                            .selectedIdCategory
                                                            .toString(),
                                                        homeProvider
                                                            .selectedNameCategory,
                                                        homeProvider
                                                            .getTitleSubCategory(
                                                                index));
                                                  },
                                                ),
                                                Text(
                                                  homeProvider
                                                      .getTitleSubCategory(
                                                          index),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ))
                                : Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      color: Colors.white70,
                                      child: const SpinKitFadingCircle(
                                        color: ColorResources.COLOR_PRIMARY,
                                        size: 60.0,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              '${getTranslated('descriptionـreport', context)}',
                              style: medium.copyWith(
                                  fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 85,
                            decoration: BoxDecoration(
                                color: Color(0xffefefef),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            margin: EdgeInsets.only(
                                top: 15, right: 15, left: 15, bottom: 25),
                            child: CustomTextField(
                              fillColor: Colors.transparent,
                              defultFont: false,
                              hasUnderLineBorder: false,
                              controller: _descriptionController,
                              maxLength: 150,
                              isPassword: false,
                              maxLines: 4,
                              inputType: TextInputType.text,
                              hintText: '',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _choose(homeProvider);
                                },
                                child: Container(
                                  padding: Provider.of<HomeProvider>(context,
                                                  listen: false)
                                              .fileUrl ==
                                          null
                                      ? const EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          top: 12,
                                          bottom: 10)
                                      : EdgeInsets.only(top: 10, bottom: 10),
                                  width: 85,
                                  height: 75,
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorResources
                                                .COLOR_DARKPRIMARY,
                                            spreadRadius: 1),
                                      ],
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  margin: const EdgeInsets.only(
                                      right: 25, left: 25, bottom: 25),
                                  child: Center(
                                      child: Provider.of<HomeProvider>(context,
                                                      listen: false)
                                                  .fileUrl ==
                                              null
                                          ? Image.asset(
                                              Images.addPhoto,
                                              fit: BoxFit.cover,
                                            )
                                          : InkWell(
                                           onTap: (){
                                             showDialog(
                                                 context: context,
                                                 barrierDismissible: false,
                                                 builder: (context) => FullScreenImageDialog(
                                                   image: '${AppConstants.BASE_URL}wwwroot/Uploads/Complanits/${Provider.of<HomeProvider>(context, listen: false).fileUrl!}',
                                                 ));
                                           },
                                            child: Image.network(
                                                '${AppConstants.BASE_URL}wwwroot/Uploads/Complanits/${Provider.of<HomeProvider>(context, listen: false).fileUrl!}',
                                                fit: BoxFit.fill,
                                              ),
                                          )
                                  ),
                                  
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
                                  btnTxt: homeProvider.reportsList.length == 0
                                      ? getTranslated('report', context)
                                      : '(${homeProvider.reportsList.length.toString()}) ${getTranslated('complete', context)}',
                                  onTap: () async {
                                    homeProvider.Description = _descriptionController.text.toString();
                                    if (homeProvider.checkListId.length > 0) {
                                      homeProvider.saveReports();
                                      showBottomCompleteReport(context);
                                    } else if (homeProvider.reportsList.length >
                                        0) {
                                      if (homeProvider.checkListId.length > 0) {
                                        homeProvider.saveReports();
                                      }
                                      showBottomCompleteReport(context);
                                    } else {
                                      await Flushbar(
                                        flushbarPosition: FlushbarPosition.TOP,
                                        backgroundColor: Colors.red,
                                        messageColor: Colors.white,
                                        message: getTranslated(
                                            "validate_report", context),
                                        duration: Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
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

  openSubCategory(BuildContext context, HomeProvider homeProvider, int index) {
    String name = homeProvider.getTitleCategory(index);
    String id = homeProvider.categoryList![index].id.toString();

    // Navigator.push(context,MaterialPageRoute(builder:(context)=> SubCategoryScreen(catId: "New ",catName: "test",) ));
    Provider.of<HomeProvider>(context, listen: false)
        .changeCategoryPoistion(index);
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

  void showBottomCompleteReport(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (context) => CompleteReportBottomSheet());
  }
}

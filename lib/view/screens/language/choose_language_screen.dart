import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_camelclub/data/model/response/language_model.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
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

class ChooseLanguageScreen extends StatelessWidget {
  final bool fromMenu;

  ChooseLanguageScreen({this.fromMenu = false});

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context, listen: false)
        .initializeAllLanguages(context);
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
                      height: 150,
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
                            height: 30,
                          ),
                          Text(
                            getTranslated('choose_the_language', context),
                            style: rubikBold.copyWith(
                                color: Colors.black, fontSize: 23),
                          ),
                          SizedBox(height: 25),
                          Consumer<LanguageProvider>(
                              builder: (context, languageProvider, child) =>
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        itemCount:
                                            languageProvider.languages.length,
                                        itemBuilder: (context, index) =>
                                            _languageWidget(
                                                context: context,
                                                languageModel: languageProvider
                                                    .languages[index],
                                                languageProvider:
                                                    languageProvider,
                                                index: index)),
                                  )),
                          Consumer<LanguageProvider>(
                              builder: (context, languageProvider, child) =>
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ButtonTopRaduis(
                                        btnTxt: getTranslated('next', context),
                                        onTap: () {
                                          if (languageProvider
                                                      .languages.length >
                                                  0 &&
                                              languageProvider.selectIndex !=
                                                  -1) {
                                            Provider.of<LocalizationProvider>(
                                                    context,
                                                    listen: false)
                                                .setLanguage(Locale(
                                              AppConstants
                                                  .languages[languageProvider
                                                      .selectIndex]
                                                  .languageCode!,
                                              AppConstants
                                                  .languages[languageProvider
                                                      .selectIndex]
                                                  .countryCode,
                                            ));

                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  Routes.getChooseUserRoute(),
                                                      (route) => false);


                                          } else {
                                            showCustomSnackBar(
                                                getTranslated(
                                                    'select_a_language',
                                                    context),
                                                context);
                                          }
                                        },
                                      ),
                                    ),
                                  )),
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

  Widget _languageWidget(
      {required BuildContext context,
      required LanguageModel languageModel,
      required LanguageProvider languageProvider,
      required int index}) {
    return InkWell(
      onTap: () {
        languageProvider.setSelectIndex(index);
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
            color: languageProvider.selectIndex == index
                ? ColorResources.COLOR_SECONDRY
                : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: ExactAssetImage(languageModel.imageUrl!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                languageModel.languageName!.contains("Arabic")
                    ? getTranslated('arabic_lan', context)
                    : getTranslated('english_lan', context),
                style: book.copyWith(
                    fontSize: 14,
                    color: languageProvider.selectIndex == index
                        ? Colors.white
                        : Colors.black),
              ),
            ],
          ),
        ),
      ),
      // child: Container(
      //   margin: EdgeInsets.all(15),
      //   padding: EdgeInsets.symmetric(horizontal: 20),
      //   decoration: BoxDecoration(
      //     color: languageProvider.selectIndex == index
      //         ? Theme.of(context).primaryColor.withOpacity(.15)
      //         : null,
      //     border: Border(
      //         top: BorderSide(
      //             width: 20.0,
      //             color: languageProvider.selectIndex == index
      //                 ? Theme.of(context).primaryColor
      //                 : Colors.transparent),
      //         bottom: BorderSide(
      //             width: 1.0,
      //             color: languageProvider.selectIndex == index
      //                 ? Theme.of(context).primaryColor
      //                 : Colors.transparent)),
      //   ),
      //   child: Container(
      //     padding: EdgeInsets.symmetric(vertical: 15),
      //     decoration: BoxDecoration(
      //       border: Border(
      //           bottom: BorderSide(
      //               width: 1.0,
      //               color: languageProvider.selectIndex == index
      //                   ? Colors.transparent
      //                   : ColorResources.COLOR_GREY_CHATEAU.withOpacity(.3))),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           children: [
      //             Image.asset(languageModel.imageUrl, width: 34, height: 34),
      //             SizedBox(width: 30),
      //             Text(
      //               languageModel.languageName,
      //               style: Theme.of(context).textTheme.headline2.copyWith(
      //                   color: Theme.of(context).textTheme.bodyText1.color),
      //             ),
      //           ],
      //         ),
      //         languageProvider.selectIndex == index
      //             ? Image.asset(Images.done,
      //                 width: 17,
      //                 height: 17,
      //                 color: Theme.of(context).primaryColor)
      //             : SizedBox.shrink()
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

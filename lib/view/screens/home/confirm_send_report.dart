import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/home_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/base/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';

// import 'base/custom_button.dart';

class ConfirmReportBottomSheet extends StatefulWidget {
  ConfirmReportBottomSheet();

  @override
  _ConfirmReportBottomSheetState createState() =>
      _ConfirmReportBottomSheetState();
}

class _ConfirmReportBottomSheetState extends State<ConfirmReportBottomSheet> {
  final accent = const Color.fromRGBO(139, 103, 248, 1);
  // final List<String> items = [
  //   'A_Item1',
  //   'A_Item2',
  //   'A_Item3',
  //   'A_Item4',
  //   'B_Item1',
  //   'B_Item2',
  //   'B_Item3',
  //   'B_Item4',
  // ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // initialChildSize: 0.4,
      // minChildSize: 0.2,
      // maxChildSize: 0.75,
      // expand: false,
      child:  Consumer<HomeProvider>(
        builder: (context,homeProvider,child)=>Container(
          height: 200,
          child:  !homeProvider.isLoading ? Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                '${getTranslated('serialNumber', context)}',
                style:
                medium.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 15,),

              Container(
                height: 40,
                width: 180,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                    BorderRadius.all(Radius.circular(15.0))),
                margin: const EdgeInsets.only(
                    top: 15, right: 15, left: 15, bottom: 25),
                child: CustomTextField(
                  defultFont: false,
                  fillColor: Colors.transparent,
                  hasUnderLineBorder: true,
                  controller: textEditingController,
                  maxLength: 20,
                  maxLines: 1,
                  isPassword: false,
                  inputType: TextInputType.text,
                  hintText: '',
                ),
              ),
              // Container(
              //   margin: EdgeInsets.all(20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         getTranslated('choose_region', context),
              //         style: medium.copyWith(fontSize: 18),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 25,),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //       color: ColorResources.COLOR_PRIMARY,
              //       borderRadius:
              //       BorderRadius.only(bottomLeft: Radius.circular(0))),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton2(
              //       isExpanded: true,
              //       hint: Text(
              //         getTranslated('region', context),
              //         style: TextStyle(
              //           fontSize: 14,
              //           color: Theme.of(context).hintColor,
              //         ),
              //       ),
              //       items: homeProvider.getRegionsTitles(context).map((item) => DropdownMenuItem<String>(
              //         value: item,
              //         child: Text(
              //           item,
              //           style: const TextStyle(
              //             fontSize: 14,
              //           ),
              //         ),
              //       ))
              //           .toList(),
              //       value: selectedValue,
              //       onChanged: (value) {
              //         if(value!=null){
              //           // homeProvider.getRegionId(value);
              //         }
              //         setState(() {
              //           selectedValue = value as String;
              //         });
              //       },
              //       buttonHeight: 40,
              //       buttonWidth: 200,
              //       itemHeight: 40,
              //       dropdownMaxHeight: 200,
              //       searchController: textEditingController,
              //       searchInnerWidget: Padding(
              //         padding: const EdgeInsets.only(
              //           top: 8,
              //           bottom: 4,
              //           right: 8,
              //           left: 8,
              //         ),
              //         child: TextFormField(
              //           controller: textEditingController,
              //           decoration: InputDecoration(
              //             isDense: true,
              //             contentPadding: const EdgeInsets.symmetric(
              //               horizontal: 10,
              //               vertical: 8,
              //             ),
              //             hintText: getTranslated('search_items_here', context),
              //             hintStyle: const TextStyle(fontSize: 12),
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //           ),
              //         ),
              //       ),
              //       searchMatchFn: (item, searchValue) {
              //         return (item.value.toString().contains(searchValue));
              //       },
              //       //This to clear the search value when you close the menu
              //       onMenuStateChange: (isOpen) {
              //         if (!isOpen) {
              //           textEditingController.clear();
              //         }
              //       },
              //     ),
              //
              //   ),
              // ),
              Expanded(child: Container()),
              const Divider(height: 4, color: ColorResources.COLOR_DARKPRIMARY),
              Container(
                height: 45,
                child: Row(children: [

                  Expanded(
                      child: InkWell(
                        onTap: () {
                          if(textEditingController.text.isNotEmpty){
                            homeProvider.confirmSendReport(context,textEditingController.text.toString());
                          }else {
                            showCustomSnackBar(getTranslated('enter_serialNumber', context), context);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: ColorResources.COLOR_SECONDRY,
                            borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(0)),
                          ),
                          child: Text(getTranslated('confirm', context),
                              style: rubikBold.copyWith(color: Colors.white)),
                        ),
                      )
                  ),
                ]),
              )
            ],
          ): Align(
            alignment: Alignment.center,
            child: Container(
              color: Colors.white70,
              child: const SpinKitFadingCircle(
                color: ColorResources.COLOR_PRIMARY,
                size: 60.0,
              ),
            ),
          )
        ),
      ),
    );
  }



}

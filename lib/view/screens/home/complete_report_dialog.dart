import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/home_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:provider/provider.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../base/custom_button.dart';
import 'confirm_send_report.dart';

// import 'base/custom_button.dart';

class CompleteReportBottomSheet extends StatefulWidget {
  CompleteReportBottomSheet();

  @override
  _CompleteReportBottomSheetState createState() =>
      _CompleteReportBottomSheetState();
}

class _CompleteReportBottomSheetState extends State<CompleteReportBottomSheet> {
  final accent = Color.fromRGBO(139, 103, 248, 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.75,
      expand: false,
      builder: (_, controller) => Consumer<HomeProvider>(
        builder: (context,homeProvider,child)=>Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    getTranslated('reports', context),
                    style: medium.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: homeProvider.reportsList.length,
                itemBuilder: (c, i) {
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: ColorResources.COLOR_DARKPRIMARY,
                                spreadRadius: 1),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              homeProvider.reportsList[i].catName,
                              style:
                              const TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                homeProvider.getListTitleReport(i),
                                style:
                                const TextStyle(color: Colors.grey, fontSize: 14,height: 1.5),
                              ),
                            ),
                            Expanded(child: Container()),
                            homeProvider.reportsList[i].image ==null ? SizedBox(): Container(height:100,width: 100,child: Image.network
                              ('${AppConstants.BASE_URL}wwwroot/Uploads/Complanits/${homeProvider.reportsList[i].image!}'))
                          ],
                        ),
                      ),
                      Positioned.directional(
                        top: 0,
                        end: 10, textDirection: TextDirection.rtl,
                        child: InkWell(
                          child: Container(
                            child: Image.asset(
                              Images.deleteReport,
                              fit: BoxFit.cover,
                            ),
                            height: 25,
                            width: 25,
                          ),
                          onTap: (){
                            homeProvider.clearItemReport(i,context);
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Divider(height: 4, color: ColorResources.COLOR_DARKPRIMARY),
            Container(
              height: 45,
              child: Row(children: [
                Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorResources.COLOR_DARKPRIMARY,
                            borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(0))),
                        child: Text(getTranslated('add_new_report', context),
                            style:
                            medium.copyWith(color: Colors.black, fontSize: 14)),
                      ),
                    )),
                Expanded(
                    child: InkWell(
                      onTap: (){
                        showBottomConfirmReport(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_SECONDRY,
                          borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(0)),
                        ),
                        child: Text(getTranslated('complete', context),
                            style: rubikBold.copyWith(color: Colors.white)),
                      ),
                    )),
              ]),
            )
          ],
        ),
      ),
    );
  }
  void showBottomConfirmReport(context) {
    showDialog(
        context: context,

        // isScrollControlled: true,
        // isDismissible: true,
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (context) => ConfirmReportBottomSheet());
  }
}

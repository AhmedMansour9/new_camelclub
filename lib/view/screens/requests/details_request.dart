import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/home_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

import '../../../data/model/requests_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../base/custom_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'base/custom_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../base/custom_snackbar.dart';
import '../home/dialog_fullscreen_image.dart';
import 'changestatus_dialog.dart';
import 'confirm_completestatus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsRequestBottomSheet extends StatefulWidget {
  final RequestsFiltertionModel filtertionModel;

  DetailsRequestBottomSheet(this.filtertionModel);

  @override
  _DetailsRequestBottomSheetState createState() =>
      _DetailsRequestBottomSheetState();
}

class _DetailsRequestBottomSheetState extends State<DetailsRequestBottomSheet> {
  final accent = Color.fromRGBO(139, 103, 248, 1);
  List<String> selectedItemsOffices = [];
  List<String> selectedItemsRegions = [];
  List<String> selectedItemsCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: .8,
      expand: false,
      builder: (_, controller) => Consumer<HomeProvider>(
          builder: (context, homeProvider, child) => !homeProvider.isLoadingDetails
              ? Container(
            color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(children: [
                        Container(
                          margin:
                          const EdgeInsetsDirectional.only(start: 20, top: 20),
                          child: Text(
                            '${getTranslated('requests2', context)}',
                            style:
                            medium.copyWith(fontSize: 20, color: Colors.black),
                          ),
                        ),

                        Container(
                          margin:
                          const EdgeInsetsDirectional.only(start: 5, top: 22),
                          alignment:
                          AlignmentDirectional.topEnd,
                          child: Text(
                          '( ${widget.filtertionModel.code.toString()} )',
                            style: const TextStyle(
                                color:
                                Color(0xfffcb67e),
                                fontSize: 18),
                          ),
                        )
                      ],),
                      Container(
                          height: 55,
                          decoration: const BoxDecoration(
                              color: Color(0xffffff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0))),
                          margin: EdgeInsets.only(
                              top: 25, right: 10, left: 10, bottom: 20),
                          padding: EdgeInsets.only(top: 0, right: 0, left: 0),
                          child: ListView.builder(
                            itemCount: widget
                                    .filtertionModel.checkListComplanit?.length ??
                                0,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            // physics: NeverScrollableScrollPhysics(),
                            // padding: EdgeInsets.only(
                            //     top: Dimensions.PADDING_SIZE_LARGE),
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorResources.COLOR_GREY,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: ColorResources.COLOR_DARKPRIMARY,
                                          spreadRadius: 1),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.filtertionModel
                                          .checkListComplanit![index].name!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ));
                            },
                          )),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                                '${getTranslated('descriptionـreport', context)} : '),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .6,
                              child: Text(
                                   widget.filtertionModel.description != null ?widget.filtertionModel.description.toString() :"" ,
                                  maxLines: 3,
                                  overflow: TextOverflow.clip,
                                  style: medium.copyWith(
                                      fontSize: 14,
                                      color: ColorResources.COLOR_GREY)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded
                            (
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15),
                              child: Row(
                                children: [
                                  Text(
                                      '${getTranslated('day', context)} : '),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    // width: MediaQuery.of(context)
                                    //     .size
                                    //     .width *
                                    //     .6,
                                    child: Text(
                                        homeProvider.getFormateDay(widget.filtertionModel.createdOn!),
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
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                      '${getTranslated('time', context)} : '),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Container(
                                    // width: MediaQuery.of(context)
                                    //     .size
                                    //     .width *
                                    //     .6,
                                    child: Text(
                                        homeProvider.getFormateTime(widget.filtertionModel.createdOn!),
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
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(

                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
                                child: Row(
                                  children: [
                                    Text('${getTranslated('region', context)} : '),
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                    Container(
                                      // width: MediaQuery.of(context)
                                      //     .size
                                      //     .width *
                                      //     .6,
                                      child: Text(
                                          '${widget.filtertionModel.officeName.toString()}',
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
                            ),

                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                        '${getTranslated('center', context)} : '),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      // width: MediaQuery.of(context)
                                      //     .size
                                      //     .width *
                                      //     .6,
                                      child: Text(
                                          widget.filtertionModel.regionName!,
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: Row(
                              children: [
                                Text('${getTranslated('carvanNumber', context)} : '),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  // width: MediaQuery.of(context)
                                  //     .size
                                  //     .width *
                                  //     .6,
                                  child: Text(
                                      '${widget.filtertionModel.carvanNumber.toString()}',
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
                            margin: EdgeInsetsDirectional.only(end: 55),
                            child: Row(
                              children: [
                                Text(
                                    '${getTranslated('room', context)} : '),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  // width: MediaQuery.of(context)
                                  //     .size
                                  //     .width *
                                  //     .6,
                                  child: Text(
                                      widget.filtertionModel.roomNumber!,
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
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: Row(
                              children: [
                                Text('${getTranslated('name_request', context)} : '),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  // width: MediaQuery.of(context)
                                  //     .size
                                  //     .width *
                                  //     .6,
                                  child: Text(
                                      '${widget.filtertionModel.userDto!.fullName.toString()}',
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
                        ],
                      ),SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15),
                        child: Row(
                          children: [
                            Text('${getTranslated('phone_number', context)} : '),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                '${widget.filtertionModel.userDto!.phoneNumber.toString()}',
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: medium.copyWith(
                                    fontSize: 14,
                                    color: ColorResources
                                        .COLOR_GREY)),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: (){
                                openDialer("0${widget.filtertionModel.userDto!.phoneNumber.toString()}");
                              },
                              child: Container(
                                  height: 25,width: 25,
                                  child: Image.asset(Images.call,fit: BoxFit.cover,)),
                            ),
                          ],
                        ),
                      ),
                      if (widget.filtertionModel.complanitStatus == 3 || widget.filtertionModel.complanitStatus == 5 || widget.filtertionModel.complanitStatus == 7 &&
                          widget.filtertionModel.technicianName !=null &&  widget.filtertionModel.technicianName!.isNotEmpty)
                        Container(
                          margin:
                          const EdgeInsetsDirectional.only(start: 20, top: 20),
                          child: Text(
                            '${getTranslated('responsible', context)}',
                            style:
                            medium.copyWith(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      if(widget.filtertionModel.complanitStatus == 3 || widget.filtertionModel.complanitStatus == 5 || widget.filtertionModel.complanitStatus == 7)
                      SizedBox(height: 10,),
                      if(widget.filtertionModel.complanitStatus == 3 || widget.filtertionModel.complanitStatus == 5 || widget.filtertionModel.complanitStatus == 7 )
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 20,top: 10),
                        child: Row(
                          children: [
                            Text('${getTranslated('tech_name', context)} : '),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              // width: MediaQuery.of(context)
                              //     .size
                              //     .width *
                              //     .6,
                              child: Text(
                                  '${widget.filtertionModel.technicianName.toString()}',
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
                      SizedBox(
                        height: 15,
                      ),
                      if(widget.filtertionModel.complanitStatus == 3 || widget.filtertionModel.complanitStatus == 5 &&
                      widget.filtertionModel.technicianDescription !=null && widget.filtertionModel.technicianDescription!.isNotEmpty)
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 20,top: 10),
                        child: Row(
                          children: [
                            Text('${getTranslated('reson', context)} : '),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              // width: MediaQuery.of(context)
                              //     .size
                              //     .width *
                              //     .6,
                              child: Text(
                                  '${widget.filtertionModel.technicianDescription.toString()}',
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
                      if(widget.filtertionModel.complanitStatus == 3 || widget.filtertionModel.complanitStatus == 5 || widget.filtertionModel.complanitStatus == 7 &&
                      widget.filtertionModel.technicianDescription !=null ||  widget.filtertionModel.technicianDescription!.isNotEmpty)
                        SizedBox(
                        height: 15,
                      ),
                      if (widget.filtertionModel.attachmentsComplanit != null &&
                          widget.filtertionModel.attachmentsComplanit!.length > 0)
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => FullScreenImageDialog(
                                      image:
                                          '${AppConstants.BASE_URL}wwwroot/Uploads/Complanits/${widget.filtertionModel.attachmentsComplanit![0]}',
                                    ));
                          },
                          child: Container(
                            margin: EdgeInsetsDirectional.only(start: 20),
                            height: 60,
                            width: 60,
                            child: Image.network(
                              '${AppConstants.BASE_URL}wwwroot/Uploads/Complanits/${widget.filtertionModel.attachmentsComplanit![0]}',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                      if (homeProvider.getUserType() == "technician" &&
                          widget.filtertionModel.complanitStatus == 1)
                        Center(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: ColorResources.COLOR_PRIMARY,
                                      spreadRadius: 1),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            alignment: AlignmentDirectional.center,
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(15),
                            width: 120,
                            height: 50,
                            child: InkWell(
                                onTap: () {
                                  changeStatus(
                                      homeProvider,
                                      "2",
                                      widget.filtertionModel.requestComplanitId
                                          .toString(),
                                      description: "جاري المعالجة");
                                },
                                child: Text(
                                    getTranslated('underproccesor', context))),
                          ),
                        ),
                      if (homeProvider.getUserType() == "technician" &&
                          widget.filtertionModel.complanitStatus == 2)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorResources.COLOR_PRIMARY,
                                          spreadRadius: 1),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0))),
                                alignment: AlignmentDirectional.center,
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.all(5),
                                width: 100,
                                height: 40,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) =>
                                              ChangeStatusDialog(
                                                status: "3",
                                                requestId: widget.filtertionModel
                                                    .requestComplanitId
                                                    .toString(),
                                              ));
                                    },
                                    child: Text(getTranslated('suspend', context),
                                        style:
                                            rubikMedium.copyWith(fontSize: 14))),
                              ),
                              if (homeProvider.getUserType() == "technician" &&
                                  widget.filtertionModel.complanitStatus == 2)
                                Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: ColorResources.COLOR_PRIMARY,
                                              spreadRadius: 1),
                                        ],
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15.0))),
                                    alignment: AlignmentDirectional.center,
                                    margin: EdgeInsets.only(top: 20),
                                    padding: EdgeInsets.all(5),
                                    width: 100,
                                    height: 40,
                                    child: InkWell(
                                        onTap: () {
                                          changeStatus(
                                              homeProvider,
                                              "7",
                                              widget.filtertionModel.requestComplanitId
                                                  .toString(),
                                              description: "تم الانتهاء من البلاغ");
                                        },
                                        child: Text(getTranslated('completed', context))),
                                  ),
                                ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorResources.COLOR_PRIMARY,
                                          spreadRadius: 1),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0))),
                                alignment: AlignmentDirectional.center,
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.all(5),
                                width: 100,
                                height: 40,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) =>
                                              ChangeStatusDialog(
                                                status: "5",
                                                requestId: widget.filtertionModel
                                                    .requestComplanitId
                                                    .toString(),
                                              ));
                                    },
                                    child: Text(getTranslated('cancele', context),
                                        style:
                                            rubikMedium.copyWith(fontSize: 14))),
                              ),
                              // Container(
                              //   decoration: const BoxDecoration(
                              //       color: Colors.white,
                              //       boxShadow: [
                              //         BoxShadow(
                              //             color: ColorResources.COLOR_PRIMARY,
                              //             spreadRadius: 1),
                              //       ],
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(15.0))),
                              //   alignment: AlignmentDirectional.center,
                              //   margin: EdgeInsets.only(top: 20),
                              //   padding: EdgeInsets.all(5),
                              //   width: 100,
                              //   height: 40,
                              //   child: InkWell(
                              //       onTap: () {
                              //         Navigator.of(context).pop();
                              //         showDialog(
                              //             context: context,
                              //             barrierDismissible: false,
                              //             builder: (context) =>
                              //                 ChangeStatusDialog(
                              //                   status: "9",
                              //                   requestId: widget.filtertionModel
                              //                       .requestComplanitId
                              //                       .toString(),
                              //                 ));
                              //       },
                              //       child: Text(
                              //         getTranslated('closed', context),
                              //         style: rubikMedium.copyWith(fontSize: 14),
                              //       )),
                              // ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
              )
              : Container(
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
                )),
    );
  }

  void changeStatus(HomeProvider homeProvider, String status, String requestId,
      {String? description, String? image}) {
    homeProvider
        .changeRequestStatus(requestId, image, status, description)
        .then((value) {
      if (value.isSuccess!) {
        if(status == "7"){
          Navigator.of(context).pop();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  ConfirmCompleteStatusDialog(
                    status: "7",
                    requestId: widget.filtertionModel
                        .requestComplanitId
                        .toString(),
                  ));
        }else {
          homeProvider.sendDataFiltertion();
          Navigator.of(context).pop();
        }


      }
    });
  }
  static Future<void> openDialer(String phoneNumber) async {
    Uri callUrl = Uri.parse('tel:=$phoneNumber');
    if (await canLaunchUrl(callUrl)) {
      await launchUrl(callUrl);
    } else {
      throw 'Could not open the dialler.';
    }

    //
    // final Uri _phoneUri = Uri(
    //     scheme: "tel",
    //     path: phoneNumber
    // );
    // try {
    //   if (await canLaunch(_phoneUri.toString()))
    //     await launch(_phoneUri.toString());
    // } catch (error) {
    //   throw("Cannot dial");
    // }
  }

}

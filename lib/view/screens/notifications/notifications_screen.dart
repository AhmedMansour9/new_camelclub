import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/notifications_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/styles.dart';

import '../../../data/model/requests_model.dart';
import '../../../provider/home_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../home/complete_report_dialog.dart';

import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home/dialog_fullscreen_image.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();

    // Provider.of<NotificationsProvider>(context, listen: false)
    //     .getNotificationsList(context);
  }

  List<String> selectedItemsReports = [];
  String? selectedValue;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();

  void _onRefresh() async {
  await  Provider.of<NotificationsProvider>(context, listen: false)
        .getNotificationsList(context);
  _refreshController.refreshCompleted();
    // // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // // if failed,use refreshFailed()
    // _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    // if (mounted) setState(() {});
   await Provider.of<NotificationsProvider>(context, listen: false)
        .getNotificationsListLoadMore(context);
   if (mounted) setState(() {});
   _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.COLOR_SECONDRY,
        centerTitle: true,
        title: Text(getTranslated('notifications', context)),
      ),
      key: drawerGlobalKey,
      endDrawerEnableOpenDragGesture: false,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, index) => Consumer<NotificationsProvider>(
              builder: (context, homeProvider, child) =>
                  InkWell(
                    onTap: (){
                      Provider.of<HomeProvider>(context, listen: false).searchByCode(homeProvider.categoryList![index].code.toString());
                      Navigator.of(context).pop();
                    },
                    child: Container(
                    height: getHight(homeProvider,index),
                    margin: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 13),
                    // padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: ColorResources.COLOR_DARKPRIMARY,
                            spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Text(
                                homeProvider.categoryList![index].title!,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Expanded(child: Container()),
                              Container(
                                alignment: AlignmentDirectional.topEnd,
                                child: Text(
                                  '${getTranslated('status', context)} : ${homeProvider.getStatus(homeProvider.categoryList![index].complanitStatus.toString(), context).toString()}',
                                  style: const TextStyle(
                                      color: ColorResources.COLOR_GREY,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Text('${getTranslated('details', context)} : '),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .6,
                                child: Text(
                                    '${homeProvider.categoryList![index].body.toString()}',
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: medium.copyWith(
                                        fontSize: 14,
                                        color: ColorResources.COLOR_GREY)),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        if (homeProvider.categoryList![index]
                                    .attachmentComplanitHistory !=
                                null &&
                            homeProvider.categoryList![index]
                                    .attachmentComplanitHistory!.length >
                                0 &&
                            homeProvider
                                    .categoryList![index].notificationType ==
                                "requestComplanit")
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => FullScreenImageDialog(
                                        image:
                                            '${AppConstants.BASE_URL}wwwroot/Uploads/Complanits/${homeProvider.categoryList![index].attachmentComplanitHistory![0]}',
                                      ));
                            },
                            child: Center(
                              child: Container(
                                height: 70,
                                width: 70,
                                child: Image.network(
                                  '${AppConstants.BASE_URL}wwwroot/Uploads/Complanits/${homeProvider.categoryList![index].attachmentComplanitHistory![0]}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        if (homeProvider
                                .categoryList![index].notificationType ==
                            "requestComplanit")
                          Expanded(child: Container()),
                        if (homeProvider
                                .categoryList![index].notificationType ==
                            "requestComplanit")
                          Container(
                            height: 35,
                            child: Row(children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  homeProvider
                                      .changeRequestStatus(
                                          homeProvider.categoryList![index]
                                              .requestComplanitId
                                              .toString(),
                                          homeProvider.categoryList![index]
                                              .complanitStatus
                                              .toString(),
                                          homeProvider.categoryList![index]
                                              .complanitHistoryId
                                              .toString(),
                                          "1",
                                          homeProvider.categoryList![index]
                                              .notificationId
                                              .toString())
                                      .then((value) {
                                    homeProvider
                                        .getNotificationsList(context);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: ColorResources.COLOR_DARKPRIMARY,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0))),
                                  child: Text(getTranslated('yes', context),
                                      style: medium.copyWith(
                                          color: Colors.black, fontSize: 12)),
                                ),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  homeProvider
                                      .changeRequestStatus(
                                          homeProvider.categoryList![index]
                                              .requestComplanitId
                                              .toString(),
                                          homeProvider.categoryList![index]
                                              .complanitStatus
                                              .toString(),
                                          homeProvider.categoryList![index]
                                              .complanitHistoryId
                                              .toString(),
                                          "2",
                                          homeProvider.categoryList![index]
                                              .notificationId
                                              .toString())
                                      .then((value) {
                                    homeProvider
                                        .getNotificationsList(context);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: ColorResources.COLOR_SECONDRY,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  child: Text(getTranslated('no', context),
                                      style: rubikBold.copyWith(
                                          color: Colors.white, fontSize: 12)),
                                ),
                              )),
                            ]),
                          )
                      ],
                    )
                    ),
                  )
          ),
          // itemExtent: 120.0,
          itemCount: Provider.of<NotificationsProvider>(context, listen: true).categoryList?.length ?? 0,
        ),
      ),
      // body: Consumer<NotificationsProvider>(
      //   builder: (context, homeProvider, child) => SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           mainAxisSize: MainAxisSize.max,
      //           children: [
      //             !homeProvider.isLoading
      //                 ? Container(
      //                     // height: 100,
      //                     height: MediaQuery.of(context).size.height,
      //                     decoration: const BoxDecoration(
      //                         color: Color(0xffffffff),
      //                         borderRadius:
      //                             BorderRadius.all(Radius.circular(0.0))),
      //                     margin: const EdgeInsets.only(top: 20),
      //                     padding: const EdgeInsets.only(
      //                         top: 0, right: 0, left: 0),
      //                     child: ListView.builder(
      //                       itemCount: homeProvider.categoryList?.length ?? 0,
      //                       shrinkWrap: true,
      //                       scrollDirection: Axis.vertical,
      //                       physics: const BouncingScrollPhysics(),
      //                       // physics: NeverScrollableScrollPhysics(),
      //                       // padding: EdgeInsets.only(
      //                       //     top: Dimensions.PADDING_SIZE_LARGE),
      //                       itemBuilder: (context, index) {
      //                         return InkWell(
      //                           onTap: () => {},
      //                           child: Container(
      //                               height: homeProvider.categoryList![index]
      //                                               .attachmentComplanitHistory !=
      //                                           null &&
      //                                       homeProvider
      //                                               .categoryList![index]
      //                                               .attachmentComplanitHistory!
      //                                               .length >
      //                                           0
      //                                   ? 220
      //                                   : 100,
      //                               margin: const EdgeInsets.symmetric(
      //                                   vertical: 5, horizontal: 13),
      //                               // padding: EdgeInsets.all(20),
      //                               decoration: BoxDecoration(
      //                                 borderRadius: BorderRadius.circular(5),
      //                                 color: Colors.white,
      //                                 boxShadow: const [
      //                                   BoxShadow(
      //                                       color: ColorResources
      //                                           .COLOR_DARKPRIMARY,
      //                                       spreadRadius: 1),
      //                                 ],
      //                               ),
      //                               child: Column(
      //                                 crossAxisAlignment:
      //                                     CrossAxisAlignment.start,
      //                                 children: [
      //                                   Container(
      //                                     padding: const EdgeInsets.symmetric(
      //                                         horizontal: 15),
      //                                     margin:
      //                                         const EdgeInsets.only(top: 20),
      //                                     child: Row(
      //                                       children: [
      //                                         Text(
      //                                           homeProvider
      //                                               .categoryList![index]
      //                                               .title!,
      //                                           style: const TextStyle(
      //                                               color: Colors.black,
      //                                               fontSize: 14),
      //                                         ),
      //                                         Expanded(child: Container()),
      //                                         Container(
      //                                           alignment:
      //                                               AlignmentDirectional
      //                                                   .topEnd,
      //                                           child: Text(
      //                                             '${getTranslated('status', context)} : ${homeProvider.getStatus(homeProvider.categoryList![index].complanitStatus.toString(), context).toString()}',
      //                                             style: const TextStyle(
      //                                                 color: ColorResources
      //                                                     .COLOR_GREY,
      //                                                 fontSize: 14),
      //                                           ),
      //                                         )
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   const SizedBox(
      //                                     height: 20,
      //                                   ),
      //                                   Container(
      //                                     padding: const EdgeInsets.symmetric(
      //                                         horizontal: 15),
      //                                     child: Row(
      //                                       children: [
      //                                         Text(
      //                                             '${getTranslated('details', context)} : '),
      //                                         const SizedBox(
      //                                           width: 10,
      //                                         ),
      //                                         Container(
      //                                           width: MediaQuery.of(context)
      //                                                   .size
      //                                                   .width *
      //                                               .6,
      //                                           child: Text(
      //                                               '${homeProvider.categoryList![index].body.toString()}',
      //                                               maxLines: 2,
      //                                               overflow:
      //                                                   TextOverflow.clip,
      //                                               style: medium.copyWith(
      //                                                   fontSize: 14,
      //                                                   color: ColorResources
      //                                                       .COLOR_GREY)),
      //                                         )
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   const SizedBox(
      //                                     height: 25,
      //                                   ),
      //                                   if (homeProvider.categoryList![index]
      //                                               .attachmentComplanitHistory !=
      //                                           null &&
      //                                       homeProvider
      //                                               .categoryList![index]
      //                                               .attachmentComplanitHistory!
      //                                               .length >
      //                                           0 && homeProvider.categoryList![index].notificationType=="requestComplanit")
      //                                     InkWell(
      //                                       onTap: () {
      //                                         showDialog(
      //                                             context: context,
      //                                             barrierDismissible: false,
      //                                             builder: (context) =>
      //                                                 FullScreenImageDialog(
      //                                                   image:
      //                                                       '${AppConstants.BASE_URL}/wwwroot/Uploads/Complanits/${homeProvider.categoryList![index].attachmentComplanitHistory![0]}',
      //                                                 ));
      //                                       },
      //                                       child: Center(
      //                                         child: Container(
      //                                           height: 70,
      //                                           width: 70,
      //                                           child: Image.network(
      //                                             '${AppConstants.BASE_URL}/wwwroot/Uploads/Complanits/${homeProvider.categoryList![index].attachmentComplanitHistory![0]}',
      //                                             fit: BoxFit.fill,
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   if(homeProvider.categoryList![index].notificationType=="requestComplanit")
      //                                   Expanded(child: Container()),
      //                                   if(homeProvider.categoryList![index].notificationType=="requestComplanit")
      //                                   Container(
      //                                     height: 35,
      //                                     child: Row(children: [
      //                                       Expanded(
      //                                           child: InkWell(
      //                                         onTap: () {
      //                                           homeProvider.changeRequestStatus(homeProvider.categoryList![index].requestComplanitId.toString(), homeProvider.categoryList![index].complanitStatus.toString(), homeProvider.categoryList![index].complanitHistoryId.toString(),
      //                                               "1", homeProvider.categoryList![index].notificationId.toString()).then((value) {
      //                                              homeProvider.getNotificationsList(context);
      //                                           });
      //                                         },
      //                                         child: Container(
      //                                           padding: const EdgeInsets.all(
      //                                               Dimensions
      //                                                   .PADDING_SIZE_SMALL),
      //                                           alignment: Alignment.center,
      //                                           decoration: const BoxDecoration(
      //                                               color: ColorResources
      //                                                   .COLOR_DARKPRIMARY,
      //                                               borderRadius:
      //                                                   BorderRadius.only(
      //                                                       bottomLeft: Radius
      //                                                           .circular(
      //                                                               0))),
      //                                           child: Text(
      //                                               getTranslated(
      //                                                   'yes',
      //                                                   context),
      //                                               style: medium.copyWith(
      //                                                   color: Colors.black,
      //                                                   fontSize: 12)),
      //                                         ),
      //                                       )),
      //                                       Expanded(
      //                                           child: InkWell(
      //                                         onTap: () {
      //                                           homeProvider.changeRequestStatus(homeProvider.categoryList![index].requestComplanitId.toString(), homeProvider.categoryList![index].complanitStatus.toString(), homeProvider.categoryList![index].complanitHistoryId.toString(),
      //                                               "2", homeProvider.categoryList![index].notificationId.toString()).then((value) {
      //                                             homeProvider.getNotificationsList(context);
      //                                           });
      //                                         },
      //                                         child: Container(
      //                                           padding: const EdgeInsets.all(
      //                                               Dimensions
      //                                                   .PADDING_SIZE_SMALL),
      //                                           alignment: Alignment.center,
      //                                           decoration: const BoxDecoration(
      //                                             color: ColorResources
      //                                                 .COLOR_SECONDRY,
      //                                             borderRadius:
      //                                                 BorderRadius.only(
      //                                                     bottomRight:
      //                                                         Radius.circular(
      //                                                             0)),
      //                                           ),
      //                                           child: Text(
      //                                               getTranslated(
      //                                                   'no', context),
      //                                               style: rubikBold.copyWith(
      //                                                   color: Colors.white,fontSize: 12)),
      //                                         ),
      //                                       )),
      //                                     ]),
      //                                   )
      //                                 ],
      //                               )),
      //                         );
      //                       },
      //                     ))
      //                 : Align(
      //                     alignment: Alignment.center,
      //                     child: Container(
      //                       color: Colors.white70,
      //                       child: const SpinKitFadingCircle(
      //                         color: ColorResources.COLOR_PRIMARY,
      //                         size: 60.0,
      //                       ),
      //                     ),
      //                   )
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
  }

 double getHight(NotificationsProvider homeProvider,int index) {
    if(homeProvider.categoryList![index].notificationType == "requestComplanit"){

      if(homeProvider.categoryList![index].attachmentComplanitHistory!=null&&homeProvider.categoryList![index].attachmentComplanitHistory!.length > 0){
        return 220;
      }else {
        return 150;
      }
    }else {
      return 120;
    }
 }
}

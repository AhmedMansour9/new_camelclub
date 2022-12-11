import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/notifications_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/screens/requests/permission_notification.dart';
import 'package:new_camelclub/view/screens/requests/search_screen.dart';

import '../../../data/model/requests_model.dart';
import '../../../provider/home_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/routes.dart';
import '../home/complete_report_dialog.dart';
import 'details_request.dart';
import 'filtertion.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:notification_permissions/notification_permissions.dart';

class RequestsScreen extends StatefulWidget with WidgetsBindingObserver{
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    super.initState();


    // if (Provider.of<HomeProvider>(context, listen: false)
    //             .getSavedCategoriesTitles() !=
    //         null &&
    //     Provider.of<HomeProvider>(context, listen: false)
    //             .getSavedCategoriesTitles()!
    //             .length >
    //         0) {
    //   Provider.of<HomeProvider>(context, listen: false)
    //           .selectedItemsCategories =
    //       Provider.of<HomeProvider>(context, listen: false)
    //           .getSavedCategoriesTitles()!;
    // }
    // if (Provider.of<HomeProvider>(context, listen: false)
    //             .getSavedOfficesTitles() !=
    //         null &&
    //     Provider.of<HomeProvider>(context, listen: false)
    //             .getSavedOfficesTitles()!
    //             .length >
    //         0) {
    //   Provider.of<HomeProvider>(context, listen: false).selectedItemsOffices =
    //       Provider.of<HomeProvider>(context, listen: false)
    //           .getSavedOfficesTitles()!;
    // }
    // if (Provider.of<HomeProvider>(context, listen: false)
    //             .getSavedRegionsTitles() !=
    //         null &&
    //     Provider.of<HomeProvider>(context, listen: false)
    //             .getSavedRegionsTitles()!
    //             .length >
    //         0) {
    //   Provider.of<HomeProvider>(context, listen: false).selectedItemsRegions =
    //       Provider.of<HomeProvider>(context, listen: false)
    //           .getSavedRegionsTitles()!;
    //   Provider.of<HomeProvider>(context, listen: false).getRegionsList(
    //       Provider.of<HomeProvider>(context, listen: false).getFilterOffices!);
    // }

    Provider.of<HomeProvider>(context, listen: false)
        .getSavedCategoriesTitles();
    Provider.of<HomeProvider>(context, listen: false).getSavedCategoriesIds();
    Provider.of<HomeProvider>(context, listen: false).sendTokenFirebase();
    Provider.of<HomeProvider>(context, listen: false).getSavedOfficesIds();
    Provider.of<HomeProvider>(context, listen: false).getSavedRegionIds();
    Provider.of<HomeProvider>(context, listen: false).checkFirstOpenStatus();
    Provider.of<HomeProvider>(context, listen: false)
        .getCategoryList(context, false);
    Provider.of<HomeProvider>(context, listen: false).getOfficesList();
    // Provider.of<HomeProvider>(context, listen: false).getRegionsList();


  }


  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<String> selectedItemsReports = [];
  String? selectedValue;

  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();

  void _onRefresh() async {
    // await  Provider.of<HomeProvider>(context, listen: false)
    //     .getNotificationsList(context);
    Provider.of<HomeProvider>(context, listen: false).sendDataFiltertion();

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
    await Provider.of<HomeProvider>(context, listen: false)
        .sendDataFiltertionLoadMore();

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
  late Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  @override
  Widget build(BuildContext context) {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => PermissionNotificationDialog());
    final List<String> items;
    items = [
      getTranslated('all', context),
      getTranslated('open_report', context),
      getTranslated('underproccesor_report', context),
      getTranslated('suspend_report', context),
      getTranslated('canceled_report', context),
      getTranslated('completed_report', context),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_SECONDRY,
          centerTitle: true,
          title: Text(getTranslated('requests', context)),
          leading: IconButton(
              icon: const Icon(Icons.notifications_active),
              onPressed: () {
                Navigator.pushNamed(context, Routes.getNotificationRoute());
              }),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => SaerchDialog());
                }),
            IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () {
                  showBottomFiltertion(context);
                }),
          ],
        ),
        key: drawerGlobalKey,
        endDrawerEnableOpenDragGesture: false,
        body: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) => SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                          color: ColorResources.COLOR_PRIMARY,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              homeProvider.getUserType() == "technician"
                                  ? getTranslated('open_report', context)
                                  : getTranslated('all', context),
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                homeProvider
                                    .changeTypeRequest(value.toString());
                                selectedValue = value as String;
                                _refreshController.requestRefresh();
                              });
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      // height: 100,
                      height: MediaQuery.of(context).size.height * .72,
                      decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
                      child: SmartRefresher(
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
                          itemBuilder: (c, index) => InkWell(
                            onTap: () => {
                              showDitailsRequest(context,
                                  homeProvider.requestsFiltertionList![index])
                            },
                            child: Container(
                                height: 220,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 13),
// padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFFE3E3E3),
                                        spreadRadius: 1),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: [
                                          homeProvider
                                                      .requestsFiltertionList![
                                                          index]
                                                      .categoryComplanitLogo !=
                                                  null
                                              ? Container(
                                                  height: 40,
                                                  width: 40,
                                                  child: Image.network(
                                                    '${AppConstants.BASE_URL}wwwroot/Uploads/Complanits/${homeProvider.requestsFiltertionList![index].categoryComplanitLogo!}',
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            homeProvider
                                                .requestsFiltertionList![index]
                                                .categoryComplanitName!,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                          Expanded(child: Container()),
                                          Row(
                                            children: [
                                              Container(
                                                alignment:
                                                AlignmentDirectional.topEnd,
                                                child: Text(
                                                  '${getTranslated('no_request', context)} ',
                                                  style: const TextStyle(
                                                      color:
                                                      ColorResources.COLOR_GREY,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                AlignmentDirectional.topEnd,
                                                child: Text(
                                                  homeProvider.requestsFiltertionList![index].code.toString(),
                                                  style: const TextStyle(
                                                      color:
                                                      Color(0xfffcb67e),
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
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
                                                      homeProvider.getFormateDay(homeProvider.requestsFiltertionList![index].createdOn!),
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
                                                      homeProvider.getFormateTime(homeProvider.requestsFiltertionList![index].createdOn!),
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
                                                        '${homeProvider.requestsFiltertionList![index].officeName.toString()}',
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
                                                        homeProvider.requestsFiltertionList![index].regionName!,
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
                                                    '${homeProvider.requestsFiltertionList![index].carvanNumber.toString()}',
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
                                              Container(
                                                child: Text(
                                                    '${getTranslated('room', context)} : '),
                                                padding: EdgeInsetsDirectional.only(start: 10),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                // width: MediaQuery.of(context)
                                                //     .size
                                                //     .width *
                                                //     .6,
                                                child: Text(
                                                    homeProvider.requestsFiltertionList![index].roomNumber!,
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




                                    Expanded(child: Container()),
                                   Row(
                                     children: [
                                       Expanded(child: Container()),
                                       Container(
                                         margin: EdgeInsetsDirectional.only(end: 15,bottom: 10),
                                         alignment:
                                         AlignmentDirectional.topStart,
                                         padding: EdgeInsets.all(10),
                                         decoration:  BoxDecoration(
                                             color:  Provider.of<NotificationsProvider>(context, listen: false).getColor(homeProvider.requestsFiltertionList![index].complanitStatus.toString(), context),
                                             borderRadius:BorderRadius.all( Radius.circular(15))),
                                         child: Text(
                                           Provider.of<NotificationsProvider>(context, listen: false).getStatus(homeProvider.requestsFiltertionList![index].complanitStatus.toString(), context),
                                           style: medium.copyWith(color:
                                           ColorResources.COLOR_WHITE,
                                               fontSize: 13),
                                         ),
                                       ),
                                     ],
                                   )
                                  ],
                                )),
                          ),
                          // itemExtent: 120.0,
                          itemCount:
                              homeProvider.requestsFiltertionList?.length ?? 0,
                        ),
                      ),
                    )
                    // : Align(
                    //     alignment: Alignment.center,
                    //     child: Container(
                    //       color: Colors.white70,
                    //       child: const SpinKitFadingCircle(
                    //         color: ColorResources.COLOR_PRIMARY,
                    //         size: 60.0,
                    //       ),
                    //     ),
                    //   )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void showBottomFiltertion(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (context) => FiltertionBottomSheet());
  }

  void showDitailsRequest(context, RequestsFiltertionModel model) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (context) => DetailsRequestBottomSheet(model));
  }
}

// ListView.builder(
// itemCount:
// homeProvider.requestsFiltertionList?.length ??
// 0,
// shrinkWrap: true,
// scrollDirection: Axis.vertical,
// physics: const BouncingScrollPhysics(),
// // physics: NeverScrollableScrollPhysics(),
// // padding: EdgeInsets.only(
// //     top: Dimensions.PADDING_SIZE_LARGE),
// itemBuilder: (context, index) {
// return;
// },
// )
// InkWell(
//   onTap: () {
//     showDitailsRequest(
//         context,
//         homeProvider
//                 .requestsFiltertionList![
//             index]);
//   },
//   child: Container(
//     width: MediaQuery.of(context)
//         .size
//         .width,
//     // margin: EdgeInsets.all(15),
//     padding: const EdgeInsets.all(
//         Dimensions.PADDING_SIZE_SMALL),
//     alignment: Alignment.center,
//     decoration: const BoxDecoration(
//       color:
//           ColorResources.COLOR_SECONDRY,
//       borderRadius: BorderRadius.only(
//           bottomRight:
//               Radius.circular(0)),
//     ),
//     child: Text(
//         getTranslated(
//             'details', context),
//         style: medium.copyWith(
//             color: Colors.white)),
//   ),
// )
// homeProvider.selectedItemsOffices != null &&
//         homeProvider.selectedItemsOffices!.length > 0
//     ? Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Row(
//           children: [
//             Text('${getTranslated('details', context)} : '),
//             const SizedBox(
//               width: 10,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * .6,
//               child: Text(
//                   '${homeProvider.mappingList(homeProvider.selectedItemsRegions)}',
//                   maxLines: 2,
//                   overflow: TextOverflow.clip,
//                   style: medium.copyWith(
//                       fontSize: 14,
//                       color: ColorResources.COLOR_GREY)),
//             )
//           ],
//         ),
//       )
//     : SizedBox(),
// homeProvider.selectedItemsRegions != null &&
//         homeProvider.selectedItemsRegions.length > 0
//     ? Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Row(
//           children: [
//             Text('${getTranslated('details', context)} : '),
//             const SizedBox(
//               width: 10,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * .6,
//               child: Text(
//                   '${homeProvider.mappingList(homeProvider.selectedItemsRegions)}',
//                   maxLines: 2,
//                   overflow: TextOverflow.clip,
//                   style: medium.copyWith(
//                       fontSize: 14,
//                       color: ColorResources.COLOR_GREY)),
//             )
//           ],
//         ),
//       )
//     : SizedBox(),
// homeProvider.selectedItemsCategories != null &&
//         homeProvider.selectedItemsCategories.length > 0
//     ? Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Row(
//           children: [
//             Text('${getTranslated('details', context)} : '),
//             const SizedBox(
//               width: 10,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * .6,
//               child: Text(
//                   '${homeProvider.mappingList(homeProvider.selectedItemsCategories)}',
//                   maxLines: 2,
//                   overflow: TextOverflow.clip,
//                   style: medium.copyWith(
//                       fontSize: 14,
//                       color: ColorResources.COLOR_GREY)),
//             )
//           ],
//         ),
//       )
//     : SizedBox(),
// !homeProvider.isLoading

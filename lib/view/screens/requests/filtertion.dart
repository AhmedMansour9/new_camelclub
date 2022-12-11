import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/home_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/strings.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/base/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../base/custom_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'base/custom_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FiltertionBottomSheet extends StatefulWidget {
  FiltertionBottomSheet();

  @override
  _FiltertionBottomSheetState createState() => _FiltertionBottomSheetState();
}

class _FiltertionBottomSheetState extends State<FiltertionBottomSheet> {
  final accent = Color.fromRGBO(139, 103, 248, 1);
  final _formKey = GlobalKey<FormState>();



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
      maxChildSize: .9,
      expand: false,
      builder: (_, controller) => Consumer<HomeProvider>(
          builder: (context, homeProvider, child) => !homeProvider
                  .isLoadingFilter
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated('filter', context),
                            style: medium.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 60, end: 60),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: ColorResources.COLOR_PRIMARY,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0))),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                getTranslated('region', context),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                            items: homeProvider
                                .getOfficesTitles(context)
                                .map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                //disable default onTap to avoid closing menu when selecting an item
                                enabled: false,
                                child: StatefulBuilder(
                                  builder: (context, menuSetState) {
                                    final _isSelected = homeProvider
                                        .selectedItemsOffices
                                        .contains(item);
                                    return InkWell(
                                      onTap: () {
                                        chooseOffice(
                                            _isSelected, item, homeProvider);
                                        // _isSelected
                                        //     ? homeProvider.selectedItemsOffices
                                        //         .remove(item)
                                        //     : homeProvider.selectedItemsOffices
                                        //         .add(item);
                                        homeProvider.getRegionsList(homeProvider
                                            .getListIdsOffices(homeProvider
                                                .selectedItemsOffices));
                                        //This rebuilds the StatefulWidget to update the button's text

                                        setState(() {});
                                        //This rebuilds the dropdownMenu Widget to update the check mark
                                        menuSetState(() {});
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            _isSelected
                                                ? const Icon(
                                                    Icons.check_box_outlined)
                                                : const Icon(Icons
                                                    .check_box_outline_blank),
                                            const SizedBox(width: 16),
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                            value: homeProvider.selectedItemsOffices.isEmpty
                                ? null
                                : homeProvider.selectedItemsOffices.last,
                            onChanged: (value) {},
                            buttonHeight: 40,
                            buttonWidth: 220,
                            itemHeight: 40,
                            itemPadding: EdgeInsets.zero,
                            selectedItemBuilder: (context) {
                              return homeProvider.getOfficesTitles(context).map(
                                (item) {
                                  return Container(
                                    alignment: AlignmentDirectional.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      showTitle(homeProvider.selectedItemsOffices),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 60, end: 60),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: ColorResources.COLOR_PRIMARY,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0))),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                getTranslated('center', context),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                            items: homeProvider
                                .getRegionsTitles(context)
                                .map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                //disable default onTap to avoid closing menu when selecting an item
                                enabled: true,
                                child: StatefulBuilder(
                                  builder: (context, menuSetState) {
                                    final _isSelected = homeProvider
                                        .selectedItemsRegions
                                        .contains(item);
                                    return InkWell(
                                      onTap: () {
                                        // _isSelected
                                        //     ? homeProvider.selectedItemsRegions
                                        //         .remove(item)
                                        //     : homeProvider.selectedItemsRegions
                                        //         .add(item);
                                        chooseRegion(
                                            _isSelected, item, homeProvider);
                                        if (item == "All" || item == "الكل") {
                                          homeProvider.setLoading();
                                        }

                                        //This rebuilds the StatefulWidget to update the button's text
                                        setState(() {});
                                        //This rebuilds the dropdownMenu Widget to update the check mark
                                        menuSetState(() {});
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            _isSelected
                                                ? const Icon(
                                                    Icons.check_box_outlined)
                                                : const Icon(Icons
                                                    .check_box_outline_blank),
                                            const SizedBox(width: 16),
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                            value: homeProvider.selectedItemsRegions.isEmpty
                                ? null
                                : homeProvider.selectedItemsRegions.first,
                            onChanged: (value) {},
                            buttonHeight: 40,
                            buttonWidth: 200,
                            itemHeight: 40,
                            itemPadding: EdgeInsets.zero,
                            selectedItemBuilder: (context) {
                              return homeProvider.getRegionsTitles(context).map(
                                (item) {
                                  return Container(
                                    alignment: AlignmentDirectional.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(showTitle(homeProvider.selectedItemsRegions),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 60, end: 60),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: ColorResources.COLOR_PRIMARY,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0))),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                getTranslated('category', context),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                            items: homeProvider
                                .getOCategoriesTitles(context)
                                .map((item) {
                              return DropdownMenuItem<String>(
                                key: ObjectKey(homeProvider.selectedItemsCategories.length),
                                value: item,
                                //disable default onTap to avoid closing menu when selecting an item
                                enabled: false,
                                child: StatefulBuilder(
                                  builder: (context, menuSetState) {
                                    final _isSelected = homeProvider
                                        .selectedItemsCategories
                                        .contains(item);
                                    return InkWell(
                                      onTap: () {
                                        chooseCategory(
                                            _isSelected, item, homeProvider);
                                        if (item == "All" || item == "الكل") {
                                          homeProvider.setLoading();
                                        }

                                        // homeProvider.setLoading(false);
                                        // This rebuilds the StatefulWidget to update the button's text
                                        setState(() {});
                                        // This rebuilds the dropdownMenu Widget to update the check mark
                                        menuSetState(() {
                                          print('staaate');
                                        });
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        padding:  EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            _isSelected
                                                ? const Icon(
                                                    Icons.check_box_outlined)
                                                : const Icon(Icons
                                                    .check_box_outline_blank),
                                            const SizedBox(width: 16),
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                            value: homeProvider.selectedItemsCategories.isEmpty
                                ? null
                                : homeProvider.selectedItemsCategories.last,
                            onChanged: (value) {

                            // setState(() {
                            //   print('valuee');
                            // });
                            },
                            buttonHeight: 40,
                            buttonWidth: 200,
                            itemHeight: 40,
                            itemPadding: EdgeInsets.zero,
                            selectedItemBuilder: (context) {
                              return homeProvider.getOCategoriesTitles(context).map(
                                (item) {
                                  return Container(
                                    alignment: AlignmentDirectional.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      showTitle(homeProvider.selectedItemsCategories),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Divider(height: 4, color: ColorResources.COLOR_DARKPRIMARY),
                    Container(
                      height: 45,
                      child: Row(children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            if (homeProvider.selectedItemsOffices.length < 1) {
                              showCustomSnackBar(
                                  getTranslated('selec_office', context),
                                  context);
                            } else if (homeProvider
                                    .selectedItemsRegions.length <
                                1) {
                              showCustomSnackBar(
                                  getTranslated('selec_region', context),
                                  context);
                            } else if (homeProvider
                                    .selectedItemsCategories.length <
                                1) {
                              showCustomSnackBar(
                                  getTranslated('selec_category', context),
                                  context);
                            } else {
                              homeProvider.confirmFilter(
                                  homeProvider.selectedItemsCategories,
                                  homeProvider.selectedItemsOffices,
                                  homeProvider.selectedItemsRegions);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorResources.COLOR_SECONDRY,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(0)),
                            ),
                            child: Text(getTranslated('confirm', context),
                                style: rubikBold.copyWith(color: Colors.white)),
                          ),
                        )),
                      ]),
                    )
                  ],
                )
              : Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.white70,
                    child: const SpinKitFadingCircle(
                      color: ColorResources.COLOR_PRIMARY,
                      size: 60.0,
                    ),
                  ),
                )),
    );
  }

  void chooseCategory(bool isSelected, String item, HomeProvider homeProvider) {
    if (item == "All" || item == "الكل") {
      if (isSelected) {
        homeProvider.selectedItemsCategories = [];
        // setState(() {});
      } else {
        homeProvider.selectedItemsCategories =
            homeProvider.getOCategoriesTitles(context);

        // setState(() {});
      }
    } else {
      isSelected
          ? homeProvider.selectedItemsCategories.remove(item)
          : homeProvider.selectedItemsCategories.add(item);
    }
  }
  void chooseRegion(bool isSelected, String item, HomeProvider homeProvider) {
    if (item == "All" || item == "الكل") {
      if (isSelected) {
        homeProvider.selectedItemsRegions = [];
        // homeProvider.setLoading(false);
        // setState(() {});
      } else {
        homeProvider.selectedItemsRegions =
            homeProvider.getRegionsTitles(context);
        // homeProvider.setLoading(true);
        // setState(() {});
      }
    } else {
      isSelected
          ? homeProvider.selectedItemsRegions.remove(item)
          : homeProvider.selectedItemsRegions.add(item);
    }
  }
  void chooseOffice(bool isSelected, String item, HomeProvider homeProvider) {
    if (item == "All" || item == "الكل") {
      if (isSelected) {
        homeProvider.selectedItemsOffices = [];
        // homeProvider.setLoading(false);
        // setState(() {});
      } else {
        homeProvider.selectedItemsOffices =
            homeProvider.getOfficesTitles(context);
        // homeProvider.setLoading(true);
        // setState(() {});
      }
    } else {
      isSelected
          ? homeProvider.selectedItemsOffices.remove(item)
          : homeProvider.selectedItemsOffices.add(item);

    }
  }
  String  showTitle (List<String> list) {
    if (list.contains(getTranslated('all', context))) {
      return getTranslated('all', context);
    } else {
      return list.join(', ');
    }
  }
}

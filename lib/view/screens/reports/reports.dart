import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../provider/notifications_provider.dart';
import '../../../provider/reportsjson_provider.dart';
import '../../../utill/color_resources.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReportssScreen extends StatefulWidget {
  const ReportssScreen({Key? key}) : super(key: key);

  @override
  _ReportssScreenState createState() => _ReportssScreenState();
}

class _ReportssScreenState extends State<ReportssScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _start = '';
  String _end = '';
  String _rangeCount = '';

  @override
  void initState() {
    super.initState();

    _start = "2022/12/01";
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd',Intl.defaultLocale = "en");
    String formattedDate = formatter.format(now);
    _end = formattedDate;
    Provider.of<ReportssProvider>(context, listen: false)
        .getReportsList(context, false, _start, _end);
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy/MM/dd',Intl.defaultLocale = "en").format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('yyyy/MM/dd',Intl.defaultLocale = "en").format(args.value.endDate ?? args.value.startDate)}';

        _start = '${DateFormat('yyyy/MM/dd',Intl.defaultLocale = "en").format(args.value.startDate)} ';
        _end =
            '${DateFormat('yyyy/MM/dd',Intl.defaultLocale = "en").format(args.value.endDate ?? args.value.startDate)} ';

        print('$_start  $_end');
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_SECONDRY,
          centerTitle: true,
          title: Text(getTranslated('reports', context)),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                _showDateRangePicker();
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: ColorResources.COLOR_PRIMARY,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(0))),
                child: Center(
                  child: Text(getTranslated('choose_your_date', context)),
                ),
              ),
            ),
            _start.isNotEmpty
                ? Container(
                    margin:
                        const EdgeInsetsDirectional.only(start: 20, top: 20),
                    child: Row(
                      children: [
                        Text('${getTranslated('from', context)} : $_start'),
                        Text('${getTranslated('to', context)} : $_end')
                      ],
                    ),
                  )
                : const SizedBox(),
            Consumer<ReportssProvider>(
              builder: (context, homeProvider, child) => !homeProvider.isLoading
                  ? Container(
                      // height: 100,
                      height: MediaQuery.of(context).size.height * .60,
                      decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
                      child: ListView.builder(
                        itemCount: homeProvider.reportsList?.length ?? 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        // physics: NeverScrollableScrollPhysics(),
                        // padding: EdgeInsets.only(
                        //     top: Dimensions.PADDING_SIZE_LARGE),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => {},
                            child: Container(
                                height: 65,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      margin: const EdgeInsets.only(top: 25),
                                      child: Row(
                                        children: [
                                          Text(
                                            homeProvider.reportsList![index]
                                                .nameProperty!,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            child: Text(
                                              homeProvider.reportsList![index]
                                                  .valueProperty
                                                  .toString(),
                                              style: const TextStyle(
                                                  color:
                                                      ColorResources.COLOR_GREY,
                                                  fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )),
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
                    ),
            )
          ],
        ));
  }

  Future _showDateRangePicker() async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: MediaQuery.of(context).size.height * 0.44,
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          Text(
                            getTranslated('choose_your_date', context),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    SfDateRangePicker(
                      view: DateRangePickerView.month,
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                      showActionButtons: true,
                      maxDate: DateTime.now(),
                      onSubmit: (Object? value) {
                        Provider.of<ReportssProvider>(context, listen: false)
                            .getReportsList(context, false, _start, _end);
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      cancelText: getTranslated('cancele', context),
                      confirmText: getTranslated('confirm', context),
                      //   initialSelectedRange: PickerDateRange(
                      //       DateTime.now().subtract(const Duration(days: 4)),
                      //       DateTime.now().add(const Duration(days: 3))),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]),
            )));
  }
}

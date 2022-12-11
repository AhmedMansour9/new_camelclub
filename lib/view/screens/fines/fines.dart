import 'package:flutter/material.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../provider/notifications_provider.dart';
import '../../../provider/reportsjson_provider.dart';
import '../../../utill/color_resources.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../auth/sign_out_confirmation_dialog.dart';

class FinesScreen extends StatefulWidget {
  const FinesScreen({Key? key}) : super(key: key);

  @override
  _FinesScreenState createState() => _FinesScreenState();
}

class _FinesScreenState extends State<FinesScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _start = '';
  String _end = '';
  String _rangeCount = '';

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
        _range = '${DateFormat('yyyy/MM/dd').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('yyyy/MM/dd').format(args.value.endDate ?? args.value.startDate)}';

        _start = '${DateFormat('yyyy/MM/dd').format(args.value.startDate)} ';
        _end = '${DateFormat('yyyy/MM/dd').format(args.value.endDate ?? args.value.startDate)} ';


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
          title: Text(getTranslated('menu', context)),
        ),
        body: Container(

        ));
  }

  logout(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SignOutConfirmationDialog());
  }
}

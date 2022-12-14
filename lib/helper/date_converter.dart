import 'package:flutter/material.dart';
import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat('hh:mm aa','ar').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }
  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy','ar').format(isoStringToLocalDate(dateTime).toLocal());
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  static bool isAvailable(String start, String end, BuildContext context, {DateTime? time}) {
    DateTime _currentTime;
    if(time != null) {
      _currentTime = time;
    }else {
      _currentTime = Provider.of<SplashProvider>(context, listen: false).currentTime;
    }
    DateTime _start = DateFormat('hh:mm:ss').parse(start);
    DateTime _end = DateFormat('hh:mm:ss').parse(end);
    DateTime _startTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _start.hour, _start.minute, _start.second);
    DateTime _endTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _end.hour, _end.minute, _end.second);
    if(_endTime.isBefore(_startTime)) {
      _endTime = _endTime.add(Duration(days: 1));
    }
   return _currentTime.isAfter(_startTime) && _currentTime.isBefore(_endTime);
  }

  static String convertTimeRange(String start, String end) {
    DateTime _startTime = DateFormat('HH:mm:ss').parse(start);
    DateTime _endTime = DateFormat('HH:mm:ss').parse(end);
    return '${DateFormat('hh:mm aa').format(_startTime)} - ${DateFormat('hh:mm aa').format(_endTime)}';
  }

  static DateTime stringTimeToDateTime(String time) {
    return DateFormat('HH:mm:ss').parse(time);
  }

  static String deliveryDateAndTimeToDate(String deliveryDate, String deliveryTime,context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    DateTime _date = DateFormat('yyyy-MM-dd').parse(deliveryDate);
    DateTime _time = DateFormat('HH:mm').parse(deliveryTime);
    return '${DateFormat('hh:mm a','$languageCode').format(_time)} ${DateFormat('dd-MMM','$languageCode').format(_date)} ';
  }

}

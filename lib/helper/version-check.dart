import 'dart:ffi';
import 'dart:io';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:new_camelclub/localization/language_constrants.dart';
// import 'package:new_camelclub/utill/styles.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// const APP_STORE_URL = 'https://apps.apple.com/eg/app/أوزان-awzan/id1595606187';
// const PLAY_STORE_URL =
//     'https://play.google.com/store/apps/details?id=com.app.awzan';
//
// Future<bool> versionCheck(context) async {
//   //Get Current installed version of app
//   final PackageInfo info = await PackageInfo.fromPlatform();
//
//   final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
//   await remoteConfig.setConfigSettings(RemoteConfigSettings(
//     fetchTimeout: Duration(minutes: 60),
//     minimumFetchInterval: Duration(seconds: 0),
//   ));
//   await remoteConfig.ensureInitialized();
//   await remoteConfig.fetchAndActivate();
//   String newVersionAndroid = remoteConfig.getString('force_update_current_version');
//   String newVersionIos = remoteConfig.getString('force_update_current_version_ios');
//   print("newversion : " + info.buildNumber);
//   if (Platform.isIOS){
//     if (double?.tryParse(newVersionIos)! > double.tryParse(info.buildNumber)!) {
//       _showVersionDialog(context);
//       return Future.value(false);
//     }
//   }else if (Platform.isAndroid){
//     if (double?.tryParse(newVersionAndroid)! > double.tryParse(info.buildNumber)!) {
//       _showVersionDialog(context);
//       return Future.value(false);
//     }
//   }
//
//
//   return Future.value(true);
// }
//
// //Show Dialog to force user to update
// _showVersionDialog(context) async {
//   await showDialog<String>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       String title = getTranslated('new_update', context);
//       String message = getTranslated('new_update2', context);
//       String btnLabel = getTranslated('update', context);
//       return new CupertinoAlertDialog(
//         title: Text(
//           title,
//           style: medium.copyWith(fontSize: 18),
//         ),
//         content: Text(
//           message,
//           style: book.copyWith(fontSize: 14),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text(
//               btnLabel,
//               style: medium,
//             ),
//             onPressed: () =>Platform.isIOS ?  _launchDeveloperPage(APP_STORE_URL) :  _launchDeveloperPage(PLAY_STORE_URL),
//           ),
//         ],
//       );
//
//     },
//   );
// }
//
// _launchDeveloperPage(String url) async {
//   final devID = '<DEV_ID>';
//   final market = 'market://dev?id=$devID';
//   if (await canLaunch(market)) {
//     await launch(market);
//   } else if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
//
// _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/strings.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:provider/provider.dart';

import '../../../provider/home_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notification_permissions/notification_permissions.dart';


class PermissionNotificationDialog extends StatefulWidget {

  PermissionNotificationDialog();

  @override
  State<PermissionNotificationDialog> createState() => _PermissionNotificationDialogState();
}

class _PermissionNotificationDialogState extends State<PermissionNotificationDialog> with WidgetsBindingObserver {
  late File? file = null;
  late PickedFile? data = null;
  final picker = ImagePicker();
  TextEditingController _descriptionController = TextEditingController();
  late Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  @override
  void initState() {
    super.initState();
    // set up the notification permissions class
    // set up the future to fetch the notification data
    permissionStatusFuture = getCheckNotificationPermStatus();
    // With this, we will be able to check if the permission is granted or not
    // when returning to the application
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification Permissions'),
        ),
        body: Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: FutureBuilder(
                future: permissionStatusFuture,
                builder: (context, snapshot) {
                  // if we are waiting for data, show a progress indicator
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('error while retrieving status: ${snapshot.error}');
                  }

                  if (snapshot.hasData) {
                    var textWidget = Text(
                      "The permission status is ${snapshot.data}",
                      style: TextStyle(fontSize: 20),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    );
                    // The permission is granted, then just show the text
                    if (snapshot.data == permGranted) {
                      return textWidget;
                    }

                    // else, we'll show a button to ask for the permissions
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        textWidget,
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                         btnTxt:"Ask for notification status".toUpperCase(),
                          onTap: () {
                            // show the dialog/open settings screen
                            NotificationPermissions.requestNotificationPermissions(
                                iosSettings: const NotificationSettingsIos(
                                    sound: true, badge: true, alert: true))
                                .then((_) {
                              // when finished, check the permission status
                              setState(() {
                                permissionStatusFuture =
                                    getCheckNotificationPermStatus();
                              });
                            });
                          },
                        )
                      ],
                    );
                  }
                  return Text("No permission status yet");
                },
              ),
            )),
      ),
    );
  }


  /// When the application has a resumed status, check for the permission
  /// status
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        permissionStatusFuture = getCheckNotificationPermStatus();
      });
    }
  }
  /// Checks the notification permission status
  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return "";
      }
    });
  }
  }


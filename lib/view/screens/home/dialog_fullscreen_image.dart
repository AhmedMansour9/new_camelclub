import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:provider/provider.dart';

import '../../../provider/home_provider.dart';


class FullScreenImageDialog extends StatefulWidget {
  final String image;
  FullScreenImageDialog({required this.image });

  @override
  State<FullScreenImageDialog> createState() => _FullScreenImageDialogState();
}

class _FullScreenImageDialogState extends State<FullScreenImageDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 200,
        child: Image.network(widget.image),
      ),
    );
  }
}

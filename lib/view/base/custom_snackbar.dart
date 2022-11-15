import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../utill/styles.dart';

Future<void> showCustomSnackBar(String message, BuildContext context, {bool isError = true}) async {
  await Flushbar(
  flushbarPosition: FlushbarPosition.TOP,
  backgroundColor: isError ? Colors.red : Colors.green,
    messageText: Text(message,style: medium.copyWith(color: Colors.white),),

  duration: Duration(seconds: 3),
  ).show(context);

}

// Future<AudioPlayer> showSong() async {
//    AudioCache player = new AudioCache();
//
//    return await player.play(AppConstants.CART_MP3);
//
// }

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text == null || text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}


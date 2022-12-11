import 'package:flutter/material.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:provider/provider.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 300;

class CustomTabItem extends StatelessWidget {
  CustomTabItem(
      {this.uniqueKey,
      this.selected,
      this.iconData,
      this.isShowCart,
      this.title,
      this.callbackFunction,
      this.textColor,
      this.iconColor});

  final UniqueKey? uniqueKey;
  final String? title;
  final IconData? iconData;
  final bool? selected;
  bool? isShowCart = false;
  final Function(UniqueKey uniqueKey)? callbackFunction;
  final Color? textColor;
  final Color? iconColor;

  final double iconYAlign = ICON_ON;
  final double textYAlign = TEXT_OFF;
  final double iconAlpha = ALPHA_ON;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   child: AnimatedAlign(
          //       duration: Duration(milliseconds: ANIM_DURATION),
          //       alignment: Alignment(0, (selected) ? TEXT_ON : TEXT_OFF),
          //       child: Padding(
          //         padding: const EdgeInsets.all(20.0),
          //         child: Text(
          //           title,
          //           overflow: TextOverflow.ellipsis,
          //           maxLines: 1,
          //         ),
          //       )),
          // ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIM_DURATION),
              curve: Curves.easeIn,
              alignment: Alignment(0, (selected!) ? ICON_OFF : ICON_ON),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: ANIM_DURATION),
                opacity: (selected!) ? ALPHA_OFF : ALPHA_ON,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      padding: EdgeInsets.all(0),
                      alignment: Alignment(0, 0),
                      icon: Icon(
                        iconData,
                        color: iconColor,
                      ),
                      onPressed: () {
                        callbackFunction!(uniqueKey!);
                      },
                    ),
                    // if (this.isShowCart!)
                    //   Provider.of<CartProvider>(context).cartList.length != 0
                    //       ? Positioned(
                    //           top: 3,
                    //           right: 7,
                    //           child: Container(
                    //             padding: EdgeInsets.all(5),
                    //             alignment: Alignment.center,
                    //             decoration: BoxDecoration(
                    //                 border: Border.all(
                    //                   width: 1.5,
                    //                   color: Colors.red,
                    //                 ),
                    //                 shape: BoxShape.circle, color: Colors.red),
                    //             child: Text(
                    //               Provider.of<CartProvider>(context)
                    //                   .cartList
                    //                   .length
                    //                   .toString(),
                    //               style: medium.copyWith(
                    //
                    //                   color: Colors.white,
                    //                   fontSize: 8),
                    //             ),
                    //           ),
                    //         )
                    //       : SizedBox(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

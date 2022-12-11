import 'package:fancy_bottom_navigation/paint/half_clipper.dart';
import 'package:fancy_bottom_navigation/paint/half_painter.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/provider/localization_provider.dart';
import 'package:new_camelclub/view/base/custom_tab.dart';
import 'package:provider/provider.dart';

const double CIRCLE_SIZE = 50;
const double ARC_HEIGHT = 70;
const double ARC_WIDTH = 90;
const double CIRCLE_OUTLINE = 10;
const double SHADOW_ALLOWANCE = 20;
const double BAR_HEIGHT = 60;

class FancyBottomNavigation extends StatefulWidget {
  FancyBottomNavigation({this.tabs,
    this.onTabChangedListener,
    this.key,
    this.initialSelection = 0,
    this.circleColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.textColor,
    this.barBackgroundColor})
      : assert(onTabChangedListener != null),
        assert(tabs != null),
        assert(tabs!.length > 1 && tabs.length < 5);

  final Function(int position)? onTabChangedListener;
  final Color? circleColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Color? textColor;
  final Color? barBackgroundColor;
  final List<TabData>? tabs;
  final int? initialSelection;

  final Key? key;

  @override
  FancyBottomNavigationState createState() => FancyBottomNavigationState();
}

class FancyBottomNavigationState extends State<FancyBottomNavigation>
    with TickerProviderStateMixin, RouteAware {
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;

  int currentSelected = 0;
  double _circleAlignX = 0;
  double _circleIconAlpha = 1;

  Color? circleColor;
  Color? activeIconColor;
  Color? inactiveIconColor;
  Color? barBackgroundColor;
  Color? textColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    activeIcon = widget.tabs![currentSelected].iconData!;

    circleColor = widget.circleColor ??
        ((Theme
            .of(context)
            .brightness == Brightness.dark)
            ? Colors.white
            : Theme
            .of(context)
            .primaryColor);

    activeIconColor = widget.activeIconColor ??
        ((Theme
            .of(context)
            .brightness == Brightness.dark)
            ? Colors.black54
            : Colors.white);

    barBackgroundColor = widget.barBackgroundColor ??
        ((Theme
            .of(context)
            .brightness == Brightness.dark)
            ? Color(0xFF212121)
            : Colors.white);
    textColor = widget.textColor ??
        ((Theme
            .of(context)
            .brightness == Brightness.dark)
            ? Colors.white
            : Colors.black54);

    inactiveIconColor = (widget.inactiveIconColor) ??
        ((Theme
            .of(context)
            .brightness == Brightness.dark)
            ? Colors.white
            : Theme
            .of(context)
            .primaryColor);
  }

  @override
  void initState() {
    super.initState();
    _setSelected(widget.tabs![widget.initialSelection!].key);
  }

  _setSelected(UniqueKey key) {
    int selected = widget.tabs!.indexWhere((tabData) => tabData.key == key);


    if (mounted) {
      setState(() {
        currentSelected = selected;
        _circleAlignX = -1 + (2 / (widget.tabs!.length - 1) * selected);
        if (Provider
            .of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode
            .contains('ar')) {
          _circleAlignX = getResult(selected)!;
        }
        print("_circleAlignX :  : $_circleAlignX :  ");
        nextIcon = widget.tabs![selected].iconData!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: BAR_HEIGHT,
          decoration: BoxDecoration(color: barBackgroundColor, boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
          ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.tabs
                !.map((t) =>
                CustomTabItem(
                    uniqueKey: t.key,
                    selected: t.key == widget.tabs![currentSelected].key,
                    iconData: t.iconData!,
                    title: t.title!,
                    isShowCart: widget.tabs!.indexOf(t) == 2 ? true:false,
                    iconColor: inactiveIconColor!,
                    textColor: textColor!,
                    callbackFunction: (uniqueKey) {
                      int selected = widget.tabs!
                          .indexWhere((tabData) => tabData.key == uniqueKey);
                      widget.onTabChangedListener!(selected);
                      _setSelected(uniqueKey);
                      _initAnimationAndStart(_circleAlignX, 1);
                    }))
                .toList(),
          ),
        ),
        Positioned.fill(
          top: -(CIRCLE_SIZE + CIRCLE_OUTLINE + SHADOW_ALLOWANCE) / 2,
          child: Container(
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIM_DURATION),
              curve: Curves.easeOut,
              alignment: Alignment(_circleAlignX, 1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FractionallySizedBox(
                  widthFactor: 1 / widget.tabs!.length,
                  child: GestureDetector(
                    onTap:
                    widget.tabs![currentSelected].onclick !=null ? widget.tabs![currentSelected].onclick :null ,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        SizedBox(
                          height:
                          CIRCLE_SIZE + CIRCLE_OUTLINE + SHADOW_ALLOWANCE,
                          width:
                          CIRCLE_SIZE + CIRCLE_OUTLINE + SHADOW_ALLOWANCE,
                          child: ClipRect(
                              clipper: HalfClipper(),
                              child: Container(
                                child: Center(
                                  child: Container(
                                      width: CIRCLE_SIZE + CIRCLE_OUTLINE,
                                      height: CIRCLE_SIZE + CIRCLE_OUTLINE,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 8)
                                          ])),
                                ),
                              )),
                        ),
                        SizedBox(
                            height: ARC_HEIGHT,
                            width: ARC_WIDTH,
                            child: CustomPaint(
                              painter: HalfPainter(barBackgroundColor!),
                            )),
                        SizedBox(
                          height: CIRCLE_SIZE,
                          width: CIRCLE_SIZE,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: circleColor),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: AnimatedOpacity(
                                duration:
                                Duration(milliseconds: ANIM_DURATION ~/ 5),
                                opacity: _circleIconAlpha,
                                child: Icon(
                                  activeIcon,
                                  color: activeIconColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _initAnimationAndStart(double from, double to) {
    _circleIconAlpha = 0;

    Future.delayed(Duration(milliseconds: ANIM_DURATION ~/ 5), () {
      setState(() {
        activeIcon = nextIcon;
      });
    }).then((_) {
      Future.delayed(Duration(milliseconds: (ANIM_DURATION ~/ 5 * 3)), () {
        setState(() {
          _circleIconAlpha = 1;
        });
      });
    });
  }

  void setPage(int page) {
    widget.onTabChangedListener!(page);
    _setSelected(widget.tabs![page].key);
    _initAnimationAndStart(_circleAlignX, 1);

    setState(() {
      currentSelected = page;
    });
  }

 double? getResult(int selected) {
    switch (selected){
      case 3 : return -1.0;
      case 2 : return -0.3;
      case 1 : return 0.3;
      case 0 : return 1.0;
    }
 }
}

class TabData {
  TabData({this.iconData, this.title, this.onclick});

  IconData? iconData;
  String? title;
  Function()? onclick;
  final UniqueKey key = UniqueKey();

}

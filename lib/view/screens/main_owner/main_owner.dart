import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_camelclub/helper/date_converter.dart';
import 'package:new_camelclub/helper/network_info.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/provider/language_provider.dart';
import 'package:new_camelclub/provider/localization_provider.dart';
import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:new_camelclub/utill/color_resources.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/images.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:new_camelclub/view/base/custom_bottombar.dart';
import 'package:new_camelclub/view/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../fines/fines.dart';
import '../reports/reports.dart';
import '../requests/requests.dart';
import '../setting/setting.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  DashboardScreen({required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

// appBar: Provider.of<SplashProvider>(context, listen: false).isRestaurantClosed() ? PreferredSize(
// preferredSize: Size.fromHeight(40),
// child: Center(
// child: Container(
// width: 1170,
// height: 40 + MediaQuery.of(context).padding.top,
// color: Theme.of(context).primaryColor,
// padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
// child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
// Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL), child: Image.asset(Images.closed, width: 25, height: 25)),
// Text(
// '${getTranslated('restaurant_is_close_now', context)} '
// '${DateConverter.convertTimeToTime('${Provider.of<SplashProvider>(context, listen: false).configModel.restaurantOpenTime}:00')}',
// style: rubikRegular.copyWith(fontSize: 12, color: Colors.black),
// ),
// ]),
// ),
// ),
// ) : null,

class _DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 2;
  int _selectedIndex = 0; //New
  List<Widget>? screens;
  List<TabData>? listTabs;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  GlobalKey bottomNavigationKey = GlobalKey();
  String? lang;
  static const List<Widget> _pages = <Widget>[
    RequestsScreen(),
    ReportssScreen(),
    FinesScreen(),
    SettingScreen(),
  ];


  @override
  void initState() {
    super.initState();
    Provider.of<LanguageProvider>(context, listen: false)
        .initializeAllLanguages(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: ColorResources.COLOR_SECONDRY));
    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);
    screens = [
      // HomeScreen(),
      RequestsScreen(),
      ReportssScreen(),
      FinesScreen(),
      SettingScreen(),
      // MenuScreen(onTap: (int pageIndex) {
      //   _setPage(pageIndex);
      // }),
    ];

    if (ResponsiveHelper.isMobilePhone()) {
      NetworkInfo.checkConnectivity(_scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    // onWillPop: () async {
    //   if (_pageIndex != 0) {
    //
    //     FancyBottomNavigationState fState = bottomNavigationKey
    //         .currentState as FancyBottomNavigationState;
    //     fState.setPage(0);
    //
    //     return false;
    //   } else {
    //     return true;
    //   }
    // },


    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        selectedItemColor: ColorResources.COLOR_SECONDRY,
        unselectedItemColor: ColorResources.COLOR_GREY,
        showUnselectedLabels: true,
        iconSize: 30,
        selectedLabelStyle: medium.copyWith(
            color: ColorResources.COLOR_SECONDRY,
            fontSize: 14),
        unselectedLabelStyle: medium.copyWith(
            color: ColorResources.COLOR_SECONDRY,
            fontSize: 12),
        items:  <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: getTranslated('requests', context),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: getTranslated('reports', context),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: getTranslated('fines', context),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: getTranslated('setting', context),
          ),
        ],
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController?.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  void initData() {
    lang = Provider.of<LocalizationProvider>(context, listen: false)
        .locale
        .languageCode;
    listTabs = [
      TabData(iconData: Icons.bookmark_border, title: getTranslated('requests', context)),
      TabData(
          iconData: Icons.favorite, title: getTranslated('favourite', context)),
      TabData(
          iconData: Icons.shopping_cart, title: getTranslated('cart', context)),
      // TabData(iconData: Icons.menu, title: getTranslated('menu', context)),
    ];
    if (lang !=null && lang!.contains("ar")) {
      screens?.reversed;
      listTabs?.reversed;
    }
    print("screeeen +$screens");
  }


// child: Scaffold(
//   key: _scaffoldKey,
//   bottomNavigationBar: FancyBottomNavigation(
//     key: bottomNavigationKey,
//     barBackgroundColor: ColorResources.COLOR_SECONDRY,
//     circleColor: Colors.white,
//     inactiveIconColor: ColorResources.COLOR_DARKPRIMARY,
//     activeIconColor: ColorResources.COLOR_SECONDRY,
//
//     tabs: listTabs,
//     onTabChangedListener: (position) {
//       setState(() {
//         _setPage(position);
//       });
//     },
//   ),
//
//
//   body: PageView.builder(
//
//     controller: _pageController,
//     itemCount: screens!.length,
//     physics: NeverScrollableScrollPhysics(),
//     itemBuilder: (context, index) {
//       return screens![index];
//     },
//   ),
// ),

}

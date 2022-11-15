import 'package:flutter/material.dart';
import 'package:new_camelclub/helper/responsive_helper.dart';
import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:new_camelclub/utill/dimensions.dart';
import 'package:new_camelclub/utill/images.dart';
import 'package:new_camelclub/utill/routes.dart';
import 'package:new_camelclub/utill/styles.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final BuildContext context;
  final bool backGroundColor;
  CustomAppBar({required this.title, this.isBackButtonExist = true, this.onBackPressed, required this.context,this.backGroundColor =true});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? Center(
      child: Container(
          color: backGroundColor ? Colors.white : Color(0xFFDED4D4),
          width: 1170,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.getMainRoute()),
                  child: Provider.of<SplashProvider>(context).baseUrls != null?  Consumer<SplashProvider>(
                      builder:(context, splash, child) => FadeInImage.assetNetwork(
                        placeholder: Images.placeholder_rectangle, image:  '${splash.baseUrls?.restaurantImageUrl}/${splash.configModel?.restaurantLogo}',
                        width: 120, height: 80,
                        imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_rectangle, width: 120, height: 80),
                      )): SizedBox(),
                ),
              ),

            ],
          )
      ),
    ) : AppBar(
      title: Text(title, style: medium.copyWith( color: backGroundColor ? Colors.black : Color(0xFF4f5967))),
      centerTitle: true,
      leading: isBackButtonExist ? IconButton(
        icon: Icon(Icons.arrow_back),
         color: backGroundColor ? Colors.black : Color(0xFF4f5967),
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) : SizedBox(),
      backgroundColor:backGroundColor ? Colors.white : Color(0xFFf7f9fa),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, ResponsiveHelper.isDesktop(context) ? 80 : 50);
}

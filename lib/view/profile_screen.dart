import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/profile_controller.dart';
import 'package:firstapp/view/add_property_screen.dart';
import 'package:firstapp/view/auth/login_screen.dart';
import 'package:firstapp/view/components/profile_list_item.dart';
import 'package:firstapp/view/contract_screen.dart';
import 'package:firstapp/view/savings.dart';
import 'package:firstapp/view/user_posted_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:io';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(414, 896), splitScreenMode: true);

    var profileInfo = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SizedBox(height: 90,),
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                GetBuilder<ProfileController>(
                  init: ProfileController(),
                  builder: (controller) => CircleAvatar(
                    radius: 80,
                    backgroundImage: controller.selectedImagee == null
                        ? AssetImage('assets/building.png')
                        : Image.file(File(controller.selectedImagee!.path))
                            .image,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: GetBuilder<ProfileController>(
                        builder: (controller) => GestureDetector(
                          onTap: () {
                            controller.uploadProfileImg();
                          },
                          child: Icon(
                            LineAwesomeIcons.camera,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),

          GetBuilder<ProfileController>(
            builder: (controller) => Text(
              controller.userModel.name.toString(),
              style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          GetBuilder<ProfileController>(
            builder: (controller) => Text(
              controller.userModel.email.toString(),
              style: TextStyle(fontSize: 12, color: primaryColor),
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          // Container(
          //   height: kSpacingUnit.w * 4,
          //   width: kSpacingUnit.w * 20,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          //     color: primaryColor,
          //   ),
          //   child: Center(
          //     child: Text(
          //       'Upgrade to PRO',
          //       style: TextStyle(color: Colors.white),

          //     ),
          //   ),
          // ),
        ],
      ),
    );

    var header = Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        Icon(
          LineAwesomeIcons.arrow_left,
          size: ScreenUtil().setSp(kSpacingUnit.w * 3),
        ),
        SizedBox(
          width: 80,
        ),
        Text(
          'Your Profile',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        //profileInfo,
        //SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: <Widget>[
          // SizedBox(height: kSpacingUnit.w * 6),
          //header,
          // SizedBox(height: 20,),
          profileInfo,
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListItem(LineAwesomeIcons.home, 'Add Your Propery', true,
                    () {
                  Get.to(AddPropertyScreen());
                }),
                ProfileListItem(LineAwesomeIcons.list, 'Your Listing', true,
                    () {
                  Get.to(UserPostsScreen());
                }),
                ProfileListItem(LineAwesomeIcons.list, 'contracts', true, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContractScreen(),));
                }),
                GetBuilder<ProfileController>(
                  builder: (controller) => ProfileListItem(
                      LineAwesomeIcons.alternate_sign_out, 'Logout', false, () {
                    controller.signOut();
                    Get.offAll(LoginScreen());
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:firstapp/controller/home_controller.dart';
import 'package:firstapp/view/auth/login_screen.dart';
import 'package:firstapp/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/controller/auth_controller.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthController> {


  @override
  Widget build(BuildContext context) {
    return Obx(
      (){
        return (Get.find<AuthController>().user == null) 
        ? LoginScreen()
        : HomeScreen();
        // GetBuilder<HomeController>(
        //   builder: (controller) => Scaffold(body: controller.currentScreen, bottomNavigationBar: buttomNavigationBar(),));
      }
    );
  }
   Widget buttomNavigationBar() {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'explore',
            
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'saved',
            
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
            
            )
        ],
        currentIndex: controller.navigatorValue,
        onTap: (index){
          controller.changeSelectedValue(index);
          },
        elevation: 0,
        selectedItemColor: Color(0xff446FAF),
        backgroundColor: Colors.grey.shade100,
        ),
    );
  }
}
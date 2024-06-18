import 'package:firstapp/view/home_screen.dart';
import 'package:firstapp/view/profile_screen.dart';
import 'package:firstapp/view/saved_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController{
  int _navigatorValue = 0;
  Widget _currentScreen = HomeScreen();

  get navigatorValue => _navigatorValue;

  get currentScreen => _currentScreen;

  void changeSelectedValue(selectedValue){
    _navigatorValue = selectedValue;
    switch(selectedValue){
            case 0: {
              _currentScreen = HomeScreen();
              break;
            }
            case 1: {
              _currentScreen = SavedScreen();
              break;
            }
            case 2: {
              _currentScreen = ProfileScreen();
              break;
            }
          }
    update();
  }
}
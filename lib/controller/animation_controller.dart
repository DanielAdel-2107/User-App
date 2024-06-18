import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class AnimationControl extends GetxController with GetSingleTickerProviderStateMixin{

   AnimationController? animationController;
   
  @override
  void onInit() {
        animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/model/user_model.dart';
import 'package:firstapp/utils/local_storage_data.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
class ProfileController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  getCurrentUser();
  }

  final LocalStorageData localStorageData = Get.find();

  File? selectedImagee;

  final imagePicker = ImagePicker();



  UserModel get userModel => _userModel;
 late UserModel _userModel;

  void getCurrentUser() async{
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    update();
  }

  Future<void> signOut() async{
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    localStorageData.deleteUser();
  }

  Future uploadProfileImg()async{

    final returnedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    selectedImagee = File(returnedImage!.path);

    update();
  }
}
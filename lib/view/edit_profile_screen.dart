import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/profile_controller.dart';
import 'package:firstapp/view/components/gesturedetector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';



class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            
          ),
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          ),

        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),

          Container(
            height: 150,
            width: 150,
            // margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                GetBuilder<ProfileController>(
                  init: ProfileController(),
                  builder: (controller) => CircleAvatar(
                    radius: 120,
                    backgroundImage: controller.selectedImagee == null? AssetImage('assets/building.png'): Image.file(File(controller.selectedImagee!.path)).image,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor
                      
                    ),
                    child: Center(
                      child: GetBuilder<ProfileController>(
                        builder: (controller) => GestureDetector(
                          onTap: (){
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



              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                  suffixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 35),

              CustomGestureDetector('Save', (){})
            ],
          ),
        ),
      
    );
  }
}
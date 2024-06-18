import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/controller/get_saved_property_controller.dart';
import 'package:firstapp/view/details_screen.dart';
import 'package:firstapp/view/theme/house_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ListingScreen extends StatefulWidget {
  final String user_id;
  const ListingScreen({super.key, required this.user_id});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  AnimationController? animationController;


  

  List<QueryDocumentSnapshot> data = [];
  bool isLoading = false;
  getData()async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users')
    .doc(widget.user_id).collection('user list').get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
                child:data.isEmpty?Text('no data') :Text('${data[0]['user list']}'),
     ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/model/saved_property_model.dart';
import 'package:firstapp/services/saved_firestore_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetSavedPropertyController extends GetxController{

  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<SavedPropertyModel> get savedPropertyModel => _savedPropertyModel;

  List<SavedPropertyModel> _savedPropertyModel = [];

  getProperties() async{
    _loading.value = true;
    SavedFireStoreProperty().getPropertiess().then((value){
      for(int i = 0; i < value.length; i++){
        _savedPropertyModel.add(SavedPropertyModel.fromJson(value[i].data() as Map));
        _loading.value = false;
      }
      update();
    });
    }

    GetSavedPropertyController(){
      getProperties();
    }

     var exist;
     Future<bool> checkExist(String docID)async{
      try{
        await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('user savings').doc(docID).get().then((value){
          exist = value.exists;
        });
        return exist;
      }
      catch(e){
        return false;
      }
    }

  void deleteDoc(String id){
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('user savings').doc(id).delete();
      // FirebaseFirestore.instance.collection("Rooms").doc(snapshot.requireData.docs[i].id).collection("Messages").doc(snapshot.requireData.docs[i].id).delete();
  }


  // List<SavedPropertyModel> _listOfCards = [];

  // List<SavedPropertyModel> get listOfCards => _listOfCards;


}
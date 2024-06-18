import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/model/property_model.dart';
import 'package:firstapp/services/firestore_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetPropertyController extends GetxController {
  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<PropertyModel> get propertyModel => _propertyModel;

  List<PropertyModel> _propertyModel = [];

  List<PropertyModel> userList = [];

  List<PropertyModel> _listOfCards = [];

  List<PropertyModel> get listOfCards => _listOfCards;

  GetPropertyController() {
    getProperties();
    loadFavorites();
  }

  Stream<QuerySnapshot> getUserProperties() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return properties.where('userId', isEqualTo: uid).snapshots();
  }

  CollectionReference properties =
      FirebaseFirestore.instance.collection('Assessor Properties');

  getProperties() async {
    _loading.value = true;
    FireStoreProperty().getPropertiess().then((value) {
      for (int i = 0; i < value.length; i++) {
        _propertyModel.add(PropertyModel.fromJson(value[i].data() as Map));
      }
      _loading.value = false;

      for (int i = 0; i < _propertyModel.length; i++) {
        if (_propertyModel[i].userEmail ==
            FirebaseAuth.instance.currentUser!.email) {
          userList.add(_propertyModel[i]);
        }
      }
      update();
    });
  }

  void toggleFavourites(PropertyModel propertyModel) async {
    final isExist = _listOfCards.contains(propertyModel);

    if (isExist) {
      _listOfCards.remove(propertyModel);
    } else {
      _listOfCards.add(propertyModel);
    }

    saveFavorites();
    update();
  }

  bool isExist(PropertyModel propertyModel) {
    return _listOfCards.contains(propertyModel);
  }

  void clearFavourites() {
    _listOfCards = [];
    saveFavorites();
    update();
  }

  void getSearchList(String loc, String minPrice, String maxPrice) {
    List filterList = propertyModel
        .where((element) =>
            element.locationn!.contains(loc) ||
            double.parse(element.price.toString()) > double.parse(minPrice) ||
            double.parse(element.price.toString()) < double.parse(maxPrice))
        .toList();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> favList = _listOfCards.map((e) => e.toJson()).toList();
    await prefs.setStringList('favorites', favList as List<String>);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favList = prefs.getStringList('favorites');
    if (favList != null) {
      _listOfCards =
          favList.map((e) => PropertyModel.fromJson(e as Map)).toList();
    }
    update();
  }
}

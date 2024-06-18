import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FilterController extends GetxController{

  var searchList = List.empty(growable: true).obs;

  getSearch(String query, var minPrice, var maxPrice) async{
   await FirebaseFirestore.instance.collection('Properties').where('Location', isEqualTo: query).get().then((value) => searchList.value = value.docs);
   await FirebaseFirestore.instance.collection('Properties').where(double.parse('price'), isGreaterThan: minPrice).get().then((value) => searchList.value = value.docs);
   await FirebaseFirestore.instance.collection('Properties').where(double.parse('price'), isLessThan: maxPrice).get().then((value) => searchList.value = value.docs);
  }

  getLocationSearch(String query)async{
    await FirebaseFirestore.instance.collection('Properties').where('Location', isEqualTo: query).get().then((value) => searchList.value = value.docs);
  }

  getPriceSearch(double pricee)async{
    await FirebaseFirestore.instance.collection('Properties').where('price').get().then((value) => searchList.value = value.docs);
  }

}
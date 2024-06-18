import 'package:firstapp/model/savings_model.dart';
import 'package:firstapp/services/database/saved_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SavingsController extends GetxController{

  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<SavingsModel> _savingModelList = [];

  List<SavingsModel> get savingModelList => _savingModelList;

  SavingsController(){
    getAllSavings();
  }

  getAllSavings()async{
    _loading.value = true;
    var dbHelper = SavingHelper.db;
   _savingModelList =  await dbHelper.getAllSavings();
   _loading.value = false;
   update();
  }

  addSaving(SavingsModel savingsModel)async{
    var dbHelper = SavingHelper.db;
    await dbHelper.insert(savingsModel);
    update();
  }
}
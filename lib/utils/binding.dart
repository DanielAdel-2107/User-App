import 'package:firstapp/controller/add_property_controller.dart';
import 'package:firstapp/controller/auth_controller.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/controller/get_saved_property_controller.dart';
import 'package:firstapp/controller/home_controller.dart';
import 'package:firstapp/controller/profile_controller.dart';
import 'package:firstapp/controller/savings_controller.dart';
import 'package:firstapp/utils/local_storage_data.dart';
import 'package:get/get.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    // Get.put(AuthController());
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => AddPropertyController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => LocalStorageData(), fenix: true);
    Get.put(() => GetPropertyController());
     Get.lazyPut(() => SavingsController(), fenix: true);

    Get.lazyPut(() => GetSavedPropertyController(), fenix: true);

    // Get.lazyPut(() => SavePropertyController(), fenix: true);
  }

}
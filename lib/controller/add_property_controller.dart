import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPropertyController extends GetxController {
  String? id,
      locationn,
      area,
      type,
      paymentType,
      amenty,
      noOfRooms,
      noOfBaths,
      price,
      downPayment,
      installmentValue,
      description,
      sqftLiving,
      sqft,
      userEmail,
      conditions,
      floors,
      grade,
      lat,
      sqftLiving15,
      sqftLot15,
      view,
      waterFront,
      zipcode,
      long,
      sqftLot,
      sqftAbov,
      yrBuild;

  List<XFile> imageList = [];

  final imagePicker = ImagePicker();

  AddPropertyController({
    this.locationn,
    this.area,
    this.type,
    this.noOfRooms,
    this.noOfBaths,
    this.amenty,
    this.paymentType,
    this.price,
    this.downPayment,
    this.installmentValue,
    this.description,
    this.userEmail,
    this.conditions,
    this.floors,
    this.grade,
    this.lat,
    this.sqftLiving15,
    this.sqftLot15,
    this.view,
    this.waterFront,
    this.zipcode,
    this.long,
    this.sqftLot,
    this.sqftAbov,
    this.sqftLiving,
    this.yrBuild,
  });

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> uploadImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages != null) {
      imageList.addAll(selectedImages);
      update();
    }
  }

  Stream<QuerySnapshot> getUserProperties() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return properties.where('userId', isEqualTo: uid).snapshots();
  }

  CollectionReference properties =
      FirebaseFirestore.instance.collection('Assessor Properties');

  Future<void> addProperty() {
    return properties
        .add({
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'Location': locationn,
          'area': area,
          'type': type,
          'price': price,
          'number of rooms': noOfRooms,
          'number of baths': noOfBaths,
          'Amenties': amenty,
          'payment type': paymentType,
          'down payment': downPayment,
          'installment value': installmentValue,
          'description': description,
          'user email': userEmail,
          'conditions': conditions,
          'floors': floors,
          'grade': grade,
          'lat': lat,
          'sqftLiving15': sqftLiving15,
          'sqftLot15': sqftLot15,
          'view': view,
          'waterFront': waterFront,
          'zipcode': zipcode,
          'long': long,
          'sqftLot': sqftLot,
          'sqftAbov': sqftAbov,
          'sqftLiving': sqftLiving,
          'yrBuild': yrBuild,
        })
        .then((value) => print("Property Added"))
        .catchError((error) => print("Failed to add property: $error"));
  }
}

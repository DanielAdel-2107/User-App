import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreProperty{

  final CollectionReference _propertyCollectionRef = FirebaseFirestore.instance.collection('Properties');

  Future<List<QueryDocumentSnapshot>> getPropertiess()async{
  var value = await _propertyCollectionRef.get();
  return value.docs;
}
}
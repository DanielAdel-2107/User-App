import 'package:cloud_firestore/cloud_firestore.dart';

class SavedFireStoreProperty{

  final _propertyCollectionRef = FirebaseFirestore.instance.collectionGroup('user savings');
  
Future<List<QueryDocumentSnapshot>> getPropertiess()async{
  var value = await _propertyCollectionRef.get();
  return value.docs;
}
}
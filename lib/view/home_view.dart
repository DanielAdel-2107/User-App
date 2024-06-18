import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertiesScreen extends StatelessWidget {
  final PropertyService _propertyService = PropertyService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _propertyService.fetchProperties(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No properties found.'));
          } else {
            final properties = snapshot.data!;
            return ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return ListTile(
                  title: Text(property['type'] ?? 'No Name'),
                  subtitle: Text(property['location'] ?? 'No Location'),
                  // Add more fields as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PropertyService {
  final CollectionReference _propertiesCollection =
      FirebaseFirestore.instance.collection('Properties');

  Future<List<Map<String, dynamic>>> fetchProperties() async {
    QuerySnapshot snapshot = await _propertiesCollection.get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contract',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Colors.blue, // Replace with your desired color
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('contract')
              .doc(user!.email)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('No contract found for current user.'));
            }

            var doc = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.only(top: 8),
              children: [
                buildContractCard(doc), // Function to build the contract card
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildContractCard(DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Contract Title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(doc['imageUrl'], height: 300)),
          ],
        ),
      ),
    );
  }
}

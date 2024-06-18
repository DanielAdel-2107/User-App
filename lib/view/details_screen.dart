// ignore_for_file: deprecated_member_use, unused_element

import 'package:firstapp/constance.dart';
import 'package:firstapp/model/property_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailsScreen extends StatelessWidget {
  late PropertyModel model;

  PropertyDetailsScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(model.type.toString()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyImage(),
            _buildPropertyInfo(),
            SizedBox(height: 16),
            _buildPropertyFeatures(),
            SizedBox(height: 16),
            _buildPropertyDescription(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    launch('tel:+2${model.brokerPhone}');
                  },
                  child: Text(
                    'phone call',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: model.brokerEmail,
                        query: encodeQueryParameters(<String, String>{
                          'subject': 'how can we help you',
                          'body': 'i aim to know more details about a property'
                        }));
                    // if(await canLaunchUrl(emailUri)){
                    //   launchUrl(emailUri);
                    // }
                    // else{
                    //   throw Exception('could not launch $emailUri');
                    // }

                    try {
                      await launchUrl(emailUri);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text('send an email', style: TextStyle(fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyImage() {
    return Container(
      height: 200,
      child: Image.asset(
        'assets/hotel_2.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPropertyInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.area} sqft, ${model.noOfRooms} bedrooms, ${model.noOfBaths} bathrooms',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            model.locationn.toString(),
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            model.price.toString(),
            style: TextStyle(
              fontSize: 24,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyFeatures() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            model.amenty.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )
          // Wrap(
          //   spacing: 8,
          //   runSpacing: 8,
          //   children: [
          //     _buildFeatureChip('Air Conditioning'),
          //     _buildFeatureChip('Swimming Pool'),
          //     _buildFeatureChip('Gym'),
          //     _buildFeatureChip('Garage'),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildPropertyDescription() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            model.description.toString(),
            style: TextStyle(fontFamily: AutofillHints.addressCity),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      backgroundColor: primaryColor,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ResualtOfFilters extends StatefulWidget {
  const ResualtOfFilters(
      {super.key,
      required this.maxPrice,
      required this.minPrice,
      required this.sqftLiving,
      required this.floor,
      required this.bathsroom,
      required this.Bedrooms});
  final String maxPrice;
  final String minPrice;
  final String sqftLiving;
  final String floor;
  final String bathsroom;
  final String Bedrooms;

  @override
  State<ResualtOfFilters> createState() => _ResualtOfFiltersState();
}

class _ResualtOfFiltersState extends State<ResualtOfFilters> {
  @override
  void initState() {
    // TODO: implement initState
    print(
        '${widget.minPrice} ${widget.maxPrice} ${widget.floor} ${widget.maxPrice} ${widget.minPrice}  ${widget.sqftLiving}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Resualt Of Filters'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Properties')
            .where('number of rooms', isEqualTo: widget.Bedrooms)
            .where('number of baths', isEqualTo: widget.bathsroom)
            .where('sqftLiving', isEqualTo: widget.sqftLiving)
            .where('floors', isEqualTo: widget.floor)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data?.docs;

          if (documents == null || documents.isEmpty) {
            return const Center(
              child: Text('No properties found matching the filters.'),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final property = documents[index].data() as Map<String, dynamic>;

              return Card(
                elevation: 10,
                child: Container(
                  height: 400,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Image.asset(
                          'assets/house.png',
                          width: double.infinity,
                        )),
                        Text('${property['type']}'),
                        Text('${property['Location']}'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(Icons.bed, color: Colors.blue),
                              Text('${property['number of rooms']} Beds'),
                              const SizedBox(width: 10),
                              const Icon(Icons.bathtub, color: Colors.blue),
                              Text('${property['number of baths']} Baths'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Action Icons
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.phone),
                                    onPressed: () {
                                      launch('tel:+2');
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.email),
                                    onPressed: () async {
                                      String? encodeQueryParameters(
                                          Map<String, String> params) {
                                        return params.entries
                                            .map((MapEntry<String, String> e) =>
                                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                            .join('&');
                                      }

                                      final Uri emailUri = Uri(
                                          scheme: 'mailto',
                                          path: '',
                                          query: encodeQueryParameters(<String,
                                              String>{
                                            'subject': 'how can we help you',
                                            'body':
                                                'i aim to know more details about a property'
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
                                  ),
                                  IconButton(
                                    icon:
                                        const Icon(LineAwesomeIcons.what_s_app),
                                    onPressed: () async {
                                      await launch("https://wa.me/+2+2");
                                    },
                                  ),
                                ],
                              ),
                              // Cost Display
                              Text(
                                '${property['price']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

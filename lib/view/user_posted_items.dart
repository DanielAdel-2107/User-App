import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/add_property_controller.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/model/property_model.dart';
import 'package:firstapp/view/details_screen.dart';
import 'package:firstapp/view/theme/house_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/animation_controller.dart';

class UserPostsScreen extends StatefulWidget {
  const UserPostsScreen({super.key});

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen>
    with TickerProviderStateMixin {
  final CollectionReference document =
      FirebaseFirestore.instance.collection('Assessor Properties');

  @override
  void initState() {
    super.initState();
    Get.put(AnimationControl()); // Ensure the controller is put only once
    Get.put(GetPropertyController()); // Ensure the controller is put only once
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  AnimationController? animationController;
  //List<PropertyListData> propertyList = PropertyListData.propertyList;
  final ScrollController _scrollController = ScrollController();

  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  Widget build(BuildContext context) {
    final AddPropertyController controller = Get.put(AddPropertyController());

    return Scaffold(
      appBar: AppBar(
        title: Text('User Item'),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Container(
          color: HouseAppTheme.buildLightTheme().scaffoldBackgroundColor,
          child: GetBuilder<GetPropertyController>(
            builder: (controller) => StreamBuilder<QuerySnapshot>(
              stream: controller.getUserProperties(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong',
                        style: TextStyle(color: Colors.black)),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No favourites added yet.',
                        style: TextStyle(color: Colors.black)),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    final int count = controller.propertyModel.length > 10
                        ? 10
                        : controller.propertyModel.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    animationController?.forward();
                    return AnimatedBuilder(
                      animation: animationController!,
                      builder: (BuildContext context, Widget? child) {
                        return FadeTransition(
                          opacity: animation,
                          child: Transform(
                            transform: Matrix4.translationValues(
                              0.0,
                              50 * (1.0 - animation.value),
                              0.0,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                top: 8,
                                bottom: 16,
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Get.to(PropertyDetailsScreen(
                                      model: controller.propertyModel[index]));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.6),
                                        offset: const Offset(4, 4),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            AspectRatio(
                                              aspectRatio: 2,
                                              child: Image.asset(
                                                'assets/hotel_2.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 16,
                                                      right: 16,
                                                      top: 8,
                                                      bottom: 8,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          data['type'],
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Text(
                                                                data[
                                                                    'Location'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   '${propertyData.dist.toStringAsFixed(1)} km to city',
                                                            //   overflow: TextOverflow.ellipsis,
                                                            //   style: TextStyle(
                                                            //     fontSize: 14,
                                                            //     color: Colors.grey
                                                            //         .withOpacity(0.8),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.bed,
                                                            color: Colors.blue),
                                                        Text(
                                                            ' ${data['number of rooms']} Rooms'),
                                                        SizedBox(width: 10),
                                                        Icon(Icons.bathtub,
                                                            color: Colors.blue),
                                                        Text(
                                                            ' ${data['number of baths']} Baths'),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // Action Icons
                                                        Row(
                                                          children: <Widget>[
                                                            IconButton(
                                                              icon: Icon(
                                                                  Icons.phone),
                                                              onPressed: () {
                                                                launch(
                                                                    'tel:+2${controller.propertyModel[index].brokerPhone}');
                                                              },
                                                            ),
                                                            IconButton(
                                                              icon: Icon(
                                                                  Icons.email),
                                                              onPressed:
                                                                  () async {
                                                                String? encodeQueryParameters(
                                                                    Map<String,
                                                                            String>
                                                                        params) {
                                                                  return params
                                                                      .entries
                                                                      .map((MapEntry<String, String>
                                                                              e) =>
                                                                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                                      .join(
                                                                          '&');
                                                                }

                                                                final Uri
                                                                    emailUri =
                                                                    Uri(
                                                                        scheme:
                                                                            'mailto',
                                                                        path:
                                                                            '${controller.propertyModel[index].brokerEmail}',
                                                                        query: encodeQueryParameters(<String,
                                                                            String>{
                                                                          'subject':
                                                                              'how can we help you',
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
                                                                  await launchUrl(
                                                                      emailUri);
                                                                } catch (e) {
                                                                  print(e
                                                                      .toString());
                                                                }
                                                              },
                                                            ),
                                                            IconButton(
                                                              icon: Icon(
                                                                  LineAwesomeIcons
                                                                      .what_s_app),
                                                              onPressed:
                                                                  () async {
                                                                await launch(
                                                                    "https://wa.me/+2+2${controller.propertyModel[index].brokerPhone}?text=hello");
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        // Cost Display
                                                        Text(
                                                          '\$${data['price']}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 19,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );

                    //return
                    // ListTile(
                    //   leading: Image.asset(data['image']),
                    //   title: Text(data['type']),
                    //   subtitle: Text('${data['location']} - ${data['num_of_beds']} - ${data['num_of_baths']}'),
                    //   trailing: Text('\$${data['price']}'),
                    //   onTap: () {
                    //     // Navigate to details screen if needed
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailsScreen(data: data),
                    //   ),
                    // );
                    //  },
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

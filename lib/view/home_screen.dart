import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/controller/get_saved_property_controller.dart';
import 'package:firstapp/controller/savings_controller.dart';
import 'package:firstapp/model/savings_model.dart';
import 'package:firstapp/utils/local_storage_data.dart';
import 'package:firstapp/view/details_screen.dart';
import 'package:firstapp/view/filters_screen.dart';
import 'package:firstapp/view/profile_screen.dart';
import 'package:firstapp/view/saved_screen.dart';
import 'package:firstapp/view/saving_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme/house_app_theme.dart';

class HomeScreen extends StatefulWidget {
  // HomeScreen({required Key key, required this.model}): super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<String> propIDlst = [];
  bool? saved;
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _toggleFavorite(int index) async {
    final key = '${index}_favorite'; // Use a unique key for each item
    bool isFavorite = !(prefs.getBool(key) ?? false);
    await prefs.setBool(key, isFavorite);
    setState(() {
      // Update UI after saving favorite status
    });
  }

  bool _isFavorite(int index) {
    final key = '${index}_favorite'; // Use the same unique key for checking
    return prefs.getBool(key) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HouseAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    getSearchBarUI(),
                                    //getTimeDateUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                getFilterBarUI(),
                              ),
                            ),
                          ];
                        },
                        body: Container(
                          color: HouseAppTheme.buildLightTheme()
                              .scaffoldBackgroundColor,
                          child: GetBuilder<GetPropertyController>(
                            init: GetPropertyController(),
                            builder: (controller) => ListView.builder(
                              itemCount: controller.propertyModel.length,
                              padding: const EdgeInsets.only(top: 8),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final int count =
                                    controller.propertyModel.length > 10
                                        ? 10
                                        : controller.propertyModel.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController?.forward();
                                return AnimatedBuilder(
                                  animation: animationController!,
                                  builder:
                                      (BuildContext context, Widget? child) {
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
                                                  model: controller
                                                      .propertyModel[index]));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.6),
                                                    offset: const Offset(4, 4),
                                                    blurRadius: 16,
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
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
                                                                    const EdgeInsets
                                                                        .only(
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
                                                                      controller
                                                                          .propertyModel[
                                                                              index]
                                                                          .type
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            22,
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
                                                                          child:
                                                                              Text(
                                                                            controller.propertyModel[index].locationn.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.grey.withOpacity(0.8),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .bed,
                                                                        color: Colors
                                                                            .blue),
                                                                    Text(
                                                                        ' ${controller.propertyModel[index].noOfRooms.toString()} Beds'),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    Icon(
                                                                        Icons
                                                                            .bathtub,
                                                                        color: Colors
                                                                            .blue),
                                                                    Text(
                                                                        ' ${controller.propertyModel[index].noOfBaths.toString()} Baths'),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        8),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    // Action Icons
                                                                    Row(
                                                                      children: <Widget>[
                                                                        IconButton(
                                                                          icon:
                                                                              Icon(Icons.phone),
                                                                          onPressed:
                                                                              () {
                                                                            launch('tel:+2${controller.propertyModel[index].brokerPhone}');
                                                                          },
                                                                        ),
                                                                        IconButton(
                                                                          icon:
                                                                              Icon(Icons.email),
                                                                          onPressed:
                                                                              () async {
                                                                            String?
                                                                                encodeQueryParameters(Map<String, String> params) {
                                                                              return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
                                                                            }

                                                                            final Uri emailUri = Uri(
                                                                                scheme: 'mailto',
                                                                                path: '${controller.propertyModel[index].brokerEmail}',
                                                                                query: encodeQueryParameters(<String, String>{
                                                                                  'subject': 'how can we help you',
                                                                                  'body': 'i aim to know more details about a property'
                                                                                }));

                                                                            try {
                                                                              await launchUrl(emailUri);
                                                                            } catch (e) {
                                                                              print(e.toString());
                                                                            }
                                                                          },
                                                                        ),
                                                                        IconButton(
                                                                          icon:
                                                                              Icon(LineAwesomeIcons.what_s_app),
                                                                          onPressed:
                                                                              () async {
                                                                            await launch("https://wa.me/+2+2${controller.propertyModel[index].brokerPhone}?text=hello");
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    // Cost Display
                                                                    Text(
                                                                      '\$${controller.propertyModel[index].price.toString()}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            19,
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
                                                    Positioned(
                                                      top: 8,
                                                      right: 8,
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                32.0),
                                                          ),
                                                          onTap: () {},
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: GetBuilder<
                                                                SavingsController>(
                                                              init:
                                                                  SavingsController(),
                                                              builder:
                                                                  (controller1) =>
                                                                      GestureDetector(
                                                                onTap: () {
                                                                  
                                                                   
                                                                   
                                                                    
                                                                  _toggleFavorite(
                                                                      index);
                                                                },
                                                                child:
                                                                    IconButton(
                                                                  icon: _isFavorite(
                                                                          index)
                                                                      ? Icon(
                                                                          Icons
                                                                              .favorite,
                                                                          color: Colors
                                                                              .red)
                                                                      : Icon(Icons
                                                                          .favorite_border),
                                                                  onPressed:
                                                                      () {
                                                                        setState(() {
                                                                           if (_isFavorite(
                                                                        index)) {
                                                                      deleteFavorite({
                                                                        'image':
                                                                            'assets/hotel_2.png',
                                                                        'type': controller
                                                                            .propertyModel[index]
                                                                            .type
                                                                            .toString(),
                                                                        'location': controller
                                                                            .propertyModel[index]
                                                                            .locationn
                                                                            .toString(),
                                                                        'num_of_room': controller
                                                                            .propertyModel[index]
                                                                            .noOfRooms
                                                                            .toString(),
                                                                        'num_of_baths': controller
                                                                            .propertyModel[index]
                                                                            .noOfBaths
                                                                            .toString(),
                                                                        'price': controller
                                                                            .propertyModel[index]
                                                                            .price
                                                                            .toString()
                                                                      });
                                                                    } else {
                                                                    
                                                                      addFavorite({
                                                                        'image':
                                                                            'assets/hotel_2.png',
                                                                        'type': controller
                                                                            .propertyModel[index]
                                                                            .type
                                                                            .toString()??'',
                                                                        'location': controller
                                                                            .propertyModel[index]
                                                                            .locationn
                                                                            .toString()??'',
                                                                        'num_of_room': controller
                                                                            .propertyModel[index]
                                                                            .noOfRooms
                                                                            .toString()??'',
                                                                        'num_of_baths': controller
                                                                            .propertyModel[index]
                                                                            .noOfBaths
                                                                            .toString()??'',
                                                                        'price': controller
                                                                            .propertyModel[index]
                                                                            .price
                                                                            .toString()??''
                                                                      });
                                                                    }
                                                                        });
                                                                    _toggleFavorite(
                                                                        index);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
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
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final CollectionReference _favorites =
      FirebaseFirestore.instance.collection('favorites');

  Future<void> deleteFavorite(Map<String, dynamic> data) async {
    try {
      var querySnapshot = await _favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorites')
          .where('price',
              isEqualTo: data[
                  'price']) // Adjust this to match the relevant field(s) and value(s) in your data
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      print('Favorite deleted successfully!');
    } catch (e) {
      print('Error deleting favorite: $e');
    }
  }

  Future<void> addFavorite(Map<String, dynamic> data) async {
    try {
      await _favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(
              'favorites') // Creates or accesses a subcollection called 'favorites'
          .add(data); // Adds a new document with a unique ID
      print('Data added to favorites successfully!');
    } catch (e) {
      print('Error adding data to favorites: $e');
    }
  }

  TextEditingController locController = TextEditingController();
  List? loclist;

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      HouseAppTheme.buildLightTheme().scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: locController,
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HouseAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'London...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HouseAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(builder: (context) {
                    return GetBuilder<GetPropertyController>(
                      init: GetPropertyController(),
                      builder: (controller) => GestureDetector(
                        onTap: () {
                         
                        },
                        child: Icon(FontAwesomeIcons.magnifyingGlass,
                            size: 20,
                            color: HouseAppTheme.buildLightTheme()
                                .scaffoldBackgroundColor),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HouseAppTheme.buildLightTheme().scaffoldBackgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HouseAppTheme.buildLightTheme().scaffoldBackgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '530 Houses found',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: HouseAppTheme.buildLightTheme()
                                    .primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HouseAppTheme.buildLightTheme().scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>SavedScreen() ,));
                            
                            },
                            child: Icon(Icons.favorite_border)),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Get.put(LocalStorageData());
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
                            },
                            child: Icon(Icons.person)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

// ignore_for_file: deprecated_member_use, unused_import

import 'package:firstapp/controller/animation_controller.dart';
import 'package:firstapp/controller/filter_controller.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/model/property_model.dart';
import 'package:firstapp/view/components/popular_filter_list.dart';
import 'package:firstapp/view/resualt_of_filters.dart';
import 'package:firstapp/view/search_bar_screen.dart';
import 'package:firstapp/view/theme/house_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'range_slider_view.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<PopularFilterListData> popularFilterListData =
      PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData =
      PopularFilterListData.accomodationList;
  bool isForSale = false;
  bool isForRent = false;

  //RangeValues _values = const RangeValues(100, 600);
  double distValue = 50.0;

  int selectedBedrooms = 0;
  int selectedBathrooms = 0;

  TextEditingController locController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController maxAreaController = TextEditingController();
  TextEditingController minAreaController = TextEditingController();
  TextEditingController amentyController = TextEditingController();
  TextEditingController floorcontroller = TextEditingController();
  TextEditingController sqllIvigcontroller = TextEditingController();

  late List filterList;

  var selectedBedroom;
  var selectedBaths;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HouseAppTheme.buildLightTheme().scaffoldBackgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, top: 8, bottom: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HouseAppTheme.buildLightTheme()
                                      .scaffoldBackgroundColor,
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
                                    onChanged: (value) {},
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    cursorColor: HouseAppTheme.buildLightTheme()
                                        .primaryColor,
                                    decoration: const InputDecoration(
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
                              color:
                                  HouseAppTheme.buildLightTheme().primaryColor,
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
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      //Get.to(SearchBarScreen());
                                      // loclist = controller.propertyModel.where((element) => element.locationn!.contains(locController.text)).toList();
                                    },
                                    child: Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        size: 20,
                                        color: HouseAppTheme.buildLightTheme()
                                            .scaffoldBackgroundColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Price Range',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width > 360
                                  ? 18
                                  : 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  controller: minPriceController,
                                  decoration: const InputDecoration(
                                    labelText: 'Min Price',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    // Update min price
                                    final minPrice = double.parse(value);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: maxPriceController,
                                  decoration: const InputDecoration(
                                    labelText: 'Max Price',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    // Update max price
                                    // Example: maxPrice = double.parse(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    const Divider(
                      height: 1,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Area Range',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width > 360
                                  ? 18
                                  : 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  controller: minAreaController,
                                  decoration: const InputDecoration(
                                    labelText: 'Min area',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    // Update min price
                                    final minPrice = double.parse(value);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: maxAreaController,
                                  decoration: const InputDecoration(
                                    labelText: 'Max area',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    // Update max price
                                    // Example: maxPrice = double.parse(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),

                    // areaRangeSliderUI(), // Replace with the area range slider UI
                    const Divider(height: 1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Amenties',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width > 360
                                  ? 18
                                  : 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Expanded(
                            child: TextFormField(
                              controller: amentyController,
                              decoration: const InputDecoration(
                                labelText: 'Amenties',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                // Update max price
                                // Example: maxPrice = double.parse(value);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Expanded(
                            child: TextFormField(
                              controller: floorcontroller,
                              decoration: const InputDecoration(
                                labelText: 'Floor',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                // Update max price
                                // Example: maxPrice = double.parse(value);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Expanded(
                            child: TextFormField(
                              controller: sqllIvigcontroller,
                              decoration: const InputDecoration(
                                labelText: 'Sqft_Living',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                // Update max price
                                // Example: maxPrice = double.parse(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    //popularFilter(),
                    const Divider(
                      height: 1,
                    ),
                    deliveryDateUI(),
                    const Divider(
                      height: 1,
                    ),
                    allAccommodationUI(),
                    const SizedBox(height: 16),
                    saleRentOptions(),
                    const Divider(
                      height: 1,
                    ),
                    // bedroomsBathroomsUI(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: Text(
                            'Bedrooms and Bathrooms',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width > 360
                                  ? 18
                                  : 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Row(
                            children: <Widget>[
                              // Bedrooms selection
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const Text('Bedrooms'),
                                    const SizedBox(height: 8),
                                    DropdownButton<int>(
                                      value: selectedBedrooms,
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedBedrooms = value!;
                                        });
                                      },
                                      items: List.generate(6, (index) {
                                        return DropdownMenuItem<int>(
                                          value: index,
                                          child:
                                              Text(index == 0 ? '0' : '$index'),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Bathrooms selection
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const Text('Bathrooms'),
                                    const SizedBox(height: 8),
                                    DropdownButton<int>(
                                      value: selectedBathrooms,
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedBathrooms = value!;
                                        });
                                      },
                                      items: List.generate(6, (index) {
                                        return DropdownMenuItem<int>(
                                          value: index,
                                          child:
                                              Text(index == 0 ? '0' : '$index'),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: HouseAppTheme.buildLightTheme().primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: GetBuilder<GetPropertyController>(
                    init: GetPropertyController(),
                    builder: (controller) => InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24.0)),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        // filterList = controller.propertyModel.where((element) =>
                        // element.locationn!.contains(locController.text) &&
                        // element.amenty!.contains(amentyController.text) &&
                        // double.parse(element.price.toString())> double.parse(minPriceController.text) &&
                        //  double.parse(element.price.toString()) <  double.parse(maxPriceController.text) &&
                        //  int.parse(element.noOfRooms.toString()) == selectedBedrooms &&
                        //  int.parse(element.noOfBaths.toString()) == selectedBathrooms
                        //  ).toList();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResualtOfFilters(
                                      Bedrooms: selectedBedrooms.toString(),
                                      bathsroom: selectedBathrooms.toString(),
                                      floor: floorcontroller.text,
                                      maxPrice: maxPriceController.text,
                                      minPrice: minPriceController.text,
                                      sqftLiving: sqllIvigcontroller.text,
                                    )));

                        print(selectedBedrooms.toString());
                        print(selectedBathrooms.toString());
                        print(floorcontroller.text);
                        print(maxPriceController.text);
                        print(minPriceController.text);
                        print(sqllIvigcontroller.text);
                      },
                      child: const Center(
                        child: Text(
                          'Apply',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RangeValues _areaRangeValues = const RangeValues(100, 1000);

  Widget areaRangeSliderUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Area (sq ft)',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RangeSlider(
            values: _areaRangeValues,
            min: 100,
            max: 1000,
            divisions: 9, // Adjust the number of divisions as needed
            onChanged: (RangeValues values) {
              setState(() {
                _areaRangeValues = values;
              });
            },
            labels: RangeLabels(
              _areaRangeValues.start.round().toString(),
              _areaRangeValues.end.round().toString(),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Property type ',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < accomodationListData.length; i++) {
      final PopularFilterListData date = accomodationListData[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date.titleTxt,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.isSelected
                        ? HouseAppTheme.buildLightTheme().primaryColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: date.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(
          height: 1,
        ));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (accomodationListData[0].isSelected) {
        accomodationListData.forEach((d) {
          d.isSelected = false;
        });
      } else {
        accomodationListData.forEach((d) {
          d.isSelected = true;
        });
      }
    } else {
      accomodationListData[index].isSelected =
          !accomodationListData[index].isSelected;

      int count = 0;
      for (int i = 0; i < accomodationListData.length; i++) {
        if (i != 0) {
          final PopularFilterListData data = accomodationListData[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == accomodationListData.length - 1) {
        accomodationListData[0].isSelected = true;
      } else {
        accomodationListData[0].isSelected = false;
      }
    }
  }

  DateTime selectedDate = DateTime.now();

  Widget deliveryDateUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Delivery Date',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey.withOpacity(0.6)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.grey)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Popular filters',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getPList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getPList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < popularFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final PopularFilterListData date = popularFilterListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        date.isSelected = !date.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            date.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: date.isSelected
                                ? HouseAppTheme.buildLightTheme().primaryColor
                                : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            date.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < popularFilterListData.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }
  // TextEditingController minPriceController = TextEditingController();
  // TextEditingController maxPriceController = TextEditingController();
  // List<PropertyModel> listOfResult = [];

  Widget priceRangeBoxes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Price Range',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: minPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Min Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // Update min price
                    final minPrice = double.parse(value);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Max Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // Update max price
                    // Example: maxPrice = double.parse(value);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget saleRentOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Sale/Rent',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isForSale = !isForSale;
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      isForSale
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: isForSale
                          ? HouseAppTheme.buildLightTheme().primaryColor
                          : Colors.grey.withOpacity(0.6),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'For Sale',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isForRent = !isForRent;
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      isForRent
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: isForRent
                          ? HouseAppTheme.buildLightTheme().primaryColor
                          : Colors.grey.withOpacity(0.6),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'For Rent',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget bedroomsBathroomsUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Bedrooms and Bathrooms',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Row(
            children: <Widget>[
              // Bedrooms selection
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Text('Bedrooms'),
                    const SizedBox(height: 8),
                    DropdownButton<int>(
                      value: selectedBedrooms,
                      onChanged: (int? value) {
                        setState(() {
                          selectedBedrooms = value!;
                        });
                      },
                      items: List.generate(6, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(index == 0 ? 'Any' : '$index'),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Bathrooms selection
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Text('Bathrooms'),
                    const SizedBox(height: 8),
                    DropdownButton<int>(
                      value: selectedBathrooms,
                      onChanged: (int? value) {
                        setState(() {
                          selectedBathrooms = value!;
                        });
                      },
                      items: List.generate(6, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(index == 0 ? 'Any' : '$index'),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
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
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 8,
          right: 8,
        ),
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
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Filters',
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
            ),
          ],
        ),
      ),
    );
  }
}

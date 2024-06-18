import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/add_property_controller.dart';
import 'package:firstapp/view/components/add_property_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
class AddPropertyScreen extends StatelessWidget {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
            child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add a Property',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 25,),
                  Form(
                    key: _formkey,
                    child: Column(children: [
                        GetBuilder<AddPropertyController>(
                          init: AddPropertyController(),
                          builder: (controller) => AddPropertyData('Location', 'Ciro, Maadi', Icons.location_city,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.locationn = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('area', '200m', Icons.area_chart,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.area = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('type', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.type = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),
                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('no. of rooms', '3', Icons.bedroom_child,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.noOfRooms = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('no of baths', '2', Icons.bathroom,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.noOfBaths = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('amenties', 'garden/pool', Icons.pool,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.amenty = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Price', '120000', Icons.price_check,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.price = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('payment type', 'cach/installment', Icons.payment,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.paymentType = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('down payment', '20000000', Icons.money_off,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.downPayment = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('installment value', '100000', Icons.payment_outlined,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.installmentValue = newvalue;
                            }
                            ),
                        ),
                        SizedBox(height: 20,),

                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('description', 'luxruy property', Icons.description,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.description = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('sqftLiving', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.sqftLiving = newvalue;
                            }
                            ),
                        ),
                                              SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('sqftLot', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.sqftLot = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Floors', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.floors = newvalue;
                            }
                            ),
                        ),

                                              SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Water Front', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.waterFront = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('View', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.view = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Conditions', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.conditions = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Grade', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.grade = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Sqft Above', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.sqftAbov = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Year Of build', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.yrBuild = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('ZipCode', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.zipcode = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Latitude', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.lat = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Longtude', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.long = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Sqft Living 15', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.sqftLiving15 = newvalue;
                            }
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('Sqft Lot 15', 'apartment', Icons.type_specimen,
                          (value){
                            if(value == null){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.sqftLot15 = newvalue;
                            }
                            ),
                        ),


                      ],),
                  ),
                  
                  
                  SizedBox(height: 20,),
            
                  GetBuilder<AddPropertyController>(
                      builder:(controller) =>ElevatedButton(onPressed:(){
              controller.uploadImage();
                      },
               child: Text('upload photo',
               style: TextStyle(color: Colors.white),),
               style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
               ),
               ),
                    ),
                  
                  SizedBox(height: 20,),
            
                   GetBuilder<AddPropertyController>(
                      builder: (controller) => Container(
              height: 200,
              child: ListView.separated(
              scrollDirection: Axis.horizontal,
               itemCount: controller.imageList.length,
               itemBuilder: (context, index){
                  return controller.imageList.isEmpty? Text('no choosen images'): Image.file(File(controller.imageList[index].path),width: 100, height: 100,);
                  //Future.delayed(Duration(seconds: 2));
              },
                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 20,),
               ),
                      ),
                    ),
                    SizedBox(height: 30,),
                  
            
                  GetBuilder<AddPropertyController>(
                    builder: (controller) =>ElevatedButton(
                      onPressed: () {
                        _formkey.currentState!.save();
                        if(_formkey.currentState!.validate()){
                          controller.userEmail = FirebaseAuth.instance.currentUser!.email;
                          controller.addProperty();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: Size(300, 50),
                        ),
                      child: const Text('Add',
                      style: TextStyle(
                        fontSize: 20
                      ),
                      ),
                    ),
                  ),
                SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        )
        ,
    );
  }
}
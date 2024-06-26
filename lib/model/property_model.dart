class PropertyModel {
  String? locationn,
      area,
      type,
      paymentType,
      price,
      amenty,
      noOfRooms,
      noOfBaths,
      downPayment,
      installmentValue,
      description,
      brokerPhone,
      brokerEmail,
      userPhone,
      userEmail,
      waterFront,
      floors,
      view,
      conditions,
      grade,
      sqftAboveYrBuilt,
      zipcode,
      lat,
      sqftLiving15,
      sqftLot15,
      sqftLiving,
      sqftLot,
      sqftAbov,
      yrBuild,
      long;

  PropertyModel({
    this.locationn,
    this.area,
    this.type,
    this.noOfRooms,
    this.noOfBaths,
    this.amenty,
    this.paymentType,
    this.price,
    this.downPayment,
    this.installmentValue,
    this.description,
    this.brokerPhone,
    this.brokerEmail,
    this.userPhone,
    this.userEmail,
    this.conditions,
    this.floors,
    this.grade,
    this.lat,
    this.sqftAboveYrBuilt,
    this.sqftLiving15,
    this.sqftLot15,
    this.view,
    this.waterFront,
    this.zipcode,
    this.long,
    this.sqftLot,
    this.sqftAbov,
    this.sqftLiving,
    this.yrBuild,
  });

  factory PropertyModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return PropertyModel();
    }
    return PropertyModel(
      locationn: map['Location'],
      area: map['area'],
      type: map['type'],
      price: map['price'],
      noOfRooms: map['number of rooms'],
      noOfBaths: map['number of baths'],
      amenty: map['Amenties'],
      paymentType: map['payment type'],
      downPayment: map['down payment'],
      installmentValue: map['installment value'],
      description: map['description'],
      brokerPhone: map['broker phone'],
      brokerEmail: map['broker email'],
      userPhone: map['user phone'],
      userEmail: map['user email'],
      waterFront: map['WaterFront'],
      floors: map['Floors'],
      view: map['View'],
      conditions: map['Conditions'],
      grade: map['Grade'],
      sqftAboveYrBuilt: map['Sqft_aboveyr_built'],
      zipcode: map['Zipcode'],
      lat: map['Lat'],
      sqftLiving15: map['Sqft_living15'],
      sqftLot15: map['Sqft_lot15'],
      sqftLiving: map['sqft_living'],
      sqftLot: map['sqft_Lot'],
      sqftAbov: map['sqft_abov'],
      yrBuild: map['yr_build'],
      long: map['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Location': locationn,
      'area': area,
      'type': type,
      'price': price,
      'number of rooms': noOfRooms,
      'number of baths': noOfBaths,
      'Amenties': amenty,
      'payment type': paymentType,
      'down payment': downPayment,
      'installment value': installmentValue,
      'description': description,
      'broker phone': brokerPhone,
      'broker email': brokerEmail,
      'user phone': userPhone,
      'user email': userEmail,
      'WaterFront': waterFront,
      'Floors': floors,
      'View': view,
      'Conditions': conditions,
      'Grade': grade,
      'Sqft_aboveyr_built': sqftAboveYrBuilt,
      'Zipcode': zipcode,
      'Lat': lat,
      'Sqft_living15': sqftLiving15,
      'Sqft_lot15': sqftLot15,
      'sqft_living': sqftLiving,
      'sqft_Lot': sqftLot,
      'sqft_abov': sqftAbov,
      'yr_build': yrBuild,
      'long': long,
    };
  }
}

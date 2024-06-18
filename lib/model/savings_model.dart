class SavingsModel{

  String? locationn, area, type, paymentType,price, amenty, noOfRooms, noOfBaths, downPayment, installmentValue, description, brokerPhone, brokerEmail;

  

  SavingsModel({
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
    // this.userEmail
    });

  SavingsModel.fromJson(Map<dynamic, dynamic> map){
    if(map == null){
      return;
    }
    locationn = map['Location'];
    area = map['area'];
    type = map['type'];
    price = map['price'];
    noOfRooms = map['number of rooms'];
    noOfBaths = map['number of baths'];
    amenty = map['Amenties'];
    paymentType = map['payment type'];
    downPayment = map['down payment'];
    installmentValue = map['installment value'];
    description = map['description'];
    brokerPhone = map['broker phone'];
    brokerEmail = map['broker email'];
    // userEmail = map['user email'];
  }

  toJson(){
    return{
      'Location': locationn,
      'area': area,
      'type': type,
      'price': price,
      'number of rooms': noOfRooms,
      'number of baths': noOfBaths,
      'Amenties': amenty,
      'payment type':paymentType,
      'down payment':downPayment,
      'installment value': installmentValue,
      'description': description,
      'broker phone': brokerPhone,
      'broker email': brokerEmail,
      // 'user email': userEmail
    };
  }
}
class UserModel{
  String? userId, email, name, phone, pic;

  UserModel(this.userId, this.email, this.name, this.phone, this.pic);

  UserModel.fromJson(Map<dynamic, dynamic> map){
    if(map == null){
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    phone = map['phone'];
    pic = map['pic'];
  }
 toJson(){
  return {
    'userId': userId,
    'email': email,
    'name': name,
    'phone': phone,
    'pic': pic
  };
 }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/model/user_model.dart';
import 'package:firstapp/services/firestore_user.dart';
import 'package:firstapp/utils/local_storage_data.dart';
import 'package:firstapp/view/auth/login_screen.dart';
import 'package:firstapp/view/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class AuthController extends GetxController{
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String email, password, name, phone;

  final _user = Rxn<User>();

  final LocalStorageData localStorageData = Get.find();

  String? get user=> _user.value?.email;
  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
   Future googleSignInMethod() async {

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    final _fireStoree = FirebaseFirestore.instance;

    final userGoogle = _auth.currentUser;
    
    UserCredential userCredential = await _auth.signInWithCredential(credential);

    User? user = userCredential.user;


    if(user != null){
      if(userCredential.additionalUserInfo!.isNewUser){
        await _fireStoree.collection('Users').doc(user.uid).set(
          {
            'userId': user.uid,
            'name': user.displayName,
            'pic': user.photoURL,
            'email': user.email,
            'phone': user.phoneNumber
          }
        );
    UserModel userModel = UserModel(user.uid.toString(), user.email.toString(), user.displayName.toString(), user.phoneNumber.toString(), '');
    setUser(userModel);
    await FirestoreUser().getCurrentUser(user.uid).then((value) {
      setUser(UserModel.fromJson(value.data() as Map));
    });
        Get.offAll(ControlView());
      }

      else{
    UserModel userModel = UserModel(user.uid.toString(), user.email.toString(), user.displayName.toString(), user.phoneNumber.toString(), '');
    setUser(userModel);
    await FirestoreUser().getCurrentUser(user.uid).then((value) {
      setUser(UserModel.fromJson(value.data() as Map));
    });
        Get.offAll(ControlView());
      }
    }

  
    // await _auth.signInWithCredential(credential).then((user) async{

    //   Get.offAll(ControlView());
    //    });
   }

//-----------------------------------------------------------------------------------------------------------
   void signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(facebookAuthCredential).then((user){
       saveUser(user);
    });
}

//-----------------------------------------------------------------------------------------------------------------
void signInWithEmailAndPasswordMethod() async{
  try{
   final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
   DocumentReference dbref = FirebaseFirestore.instance.collection('Users').doc(credential.user!.uid);
    if(credential.user!.emailVerified){
      dbref.get().then((data) async{
        if(!data.exists){
          saveUser(credential);
      await FirestoreUser().getCurrentUser(credential.user!.uid).then((value) {
      setUser(UserModel.fromJson(value.data() as Map));
    });
          Get.offAll(ControlView());
        }
        else{
        await FirestoreUser().getCurrentUser(credential.user!.uid).then((value) {
      setUser(UserModel.fromJson(value.data() as Map));
        });
          Get.offAll(ControlView());
        }
      });
    }
    else{
      Get.defaultDialog(
      title: 'login up issue',
      titleStyle: TextStyle(color: Color(0xffFFFFFF)),
      middleText: 'email has not been verified, please check your mail to verify your account',
      middleTextStyle: TextStyle(color: Color(0xffFFFFFF)),
      backgroundColor: const Color(0xff446FAF),
      textConfirm: 'Ok',
      confirmTextColor: Color(0xffFFFFFF),
    );
    }
  }on FirebaseAuthException catch(e){

    if(_auth.currentUser == null){
      Get.snackbar('login issue', e.code.toString(), colorText: Colors.red, snackPosition: SnackPosition.TOP);
    }

    
  else if (e.code == 'wrong-password') {
    // print('Wrong password provided for that user.');
    Get.defaultDialog(
      title: 'sign up issue',
      titleStyle: TextStyle(color: Color(0xffFFFFFF)),
      middleText: 'wrong password provided',
      middleTextStyle: TextStyle(color: Color(0xffFFFFFF)),
      backgroundColor: const Color(0xff446FAF),
      textConfirm: 'confirm',
      textCancel: 'cancel',
      cancelTextColor: Color(0xffFFFFFF),
      confirmTextColor: Color(0xffFFFFFF)
    );
  }

    //print(e);
    else{
    Get.snackbar('error login account', e.toString(), colorText: const Color(0xff000000), snackPosition: SnackPosition.BOTTOM);}
  }
}

//-----------------------------------------------------------------------------------------------------
void createAccountWithEmailAndPasswordMethod() async{
  try{
    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
      Get.offAll(LoginScreen());
    });

    _auth.currentUser!.sendEmailVerification();
  }on FirebaseAuthException catch(e){

    if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    Get.defaultDialog(
      title: 'sign up issue',
      titleStyle: TextStyle(color: Color(0xffFFFFFF)),
      middleText: 'the password provided is weak',
      middleTextStyle: TextStyle(color: Color(0xffFFFFFF)),
      backgroundColor: const Color(0xff446FAF),
      textConfirm: 'confirm',
      textCancel: 'cancel',
      cancelTextColor: Color(0xffFFFFFF),
      confirmTextColor: Color(0xffFFFFFF)
    );
  } 
  else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    Get.defaultDialog(
      title: 'sign up issue',
      middleText: 'The account already exists for that email.',
      backgroundColor: const Color(0xff446FAF),
      textConfirm: 'confirm',
      textCancel: 'cancel',
      cancelTextColor: Color(0xffFFFFFF),
      confirmTextColor: Color(0xffFFFFFF)

    );
  }

    //print(e);
    Get.snackbar('error sign up account', e.toString(), colorText:const Color(0xff000000), snackPosition: SnackPosition.BOTTOM);
  }
}


//-------------------------------------------------------------------------------------------------------
void saveUser(UserCredential user)async{

  UserModel userModel = UserModel(user.user!.uid, user.user!.email,
   name == null? user.user!.displayName :  name,
    phone== null? user.user!.phoneNumber :  phone,
     '');

  await FirestoreUser().addUserToFirestore(userModel);

  setUser(userModel);
}

void setUser(UserModel userModel) async{
  await localStorageData.setUser(userModel);
}
//------------------------------------------------------------

// List<String> propIDlst = [];
// Future idListFunc() async{
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Properties').get();
//   for(QueryDocumentSnapshot document in snapshot.docs){
//     String documetID = document.id;
//     propIDlst.add(documetID);
//     //final datbaseRef = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
    
//   }
//   final datbaseRef = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
  
//   // datbaseRef.collection('user list').add(
    
//   // );
// }
// List<QueryDocumentSnapshot> subdata = [];
// bool isLoading = true;
//  addCollection() async{
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('user list').get();
//   subdata.addAll(snapshot.docs);
//   isLoading = false;
//   update();
// }

// userListing() async{
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Properties').get();

// }


//  final databaseReference = Firestore.instance;
// databaseReference.collection('main collection name').document( unique id).collection('string name').document().setData(); // your answer missing **.document()**  before setData

// void forgotPassowrdMethod() async{
//   await _auth.sendPasswordResetEmail(email: email);
// }
// void signOutMethod(){
//   _auth.signOut();
//   _googleSignIn.disconnect();
// }
}
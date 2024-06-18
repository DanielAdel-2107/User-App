import 'package:firstapp/view/auth/login_screen.dart';
import 'package:firstapp/view/auth/signup_screen.dart';
import 'package:flutter/material.dart';
class WelcomePage extends StatelessWidget {
      const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget> [
              Column(
                children: <Widget> [
                 const Text(
                    'Make Yourself at Home.',
                    style: TextStyle(
                      color: Color.fromARGB(255, 68, 111, 175),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                 const SizedBox(height: 20,),
                  Text(
                    'The leading real estate marketplace. Search millions of for-sale and rental listings, compare PropScan home values and connect with the top Real Estate Agencies',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700],
                    fontSize: 15
                    ),
                    ),
              ]
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/Tiny house-amico5.png')
                  )
                ),
              ),
              Column(
                children:<Widget> [
                  MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    minWidth: double.infinity,
                    height: 60,
                    shape: RoundedRectangleBorder(
                      side:const BorderSide(
                        color: Color.fromARGB(255, 68, 111, 175)
                         ),
                         borderRadius: BorderRadius.circular(50)
                        ),
                        child:const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color.fromARGB(255, 68, 111, 175)
                          ),
                          ),
                  ),
                 const SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                    },
                    minWidth: double.infinity,
                    height: 60,
                    shape: RoundedRectangleBorder(
                      side:const BorderSide(
                        color: Colors.transparent
                         ),
                         borderRadius: BorderRadius.circular(50)
                        ),
                        color:const Color.fromARGB(255, 68, 111, 175),
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white
                          ),
                          ),
                         
                  ),
                ],
              )
            ],
          ),
         
        ),
      ),
    );
  }
}
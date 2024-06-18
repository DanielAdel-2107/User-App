import 'package:flutter/material.dart';
class CustomSocialIcon extends StatelessWidget{
var icon;
var text;
var ontap;
CustomSocialIcon(this.icon, this.text, this.ontap);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(children: [
        Image.asset(icon, width: 45,height: 45),
        Text(text, style: TextStyle(fontSize: 10))
      ]),
    );
  }
}
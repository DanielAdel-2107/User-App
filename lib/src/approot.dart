import 'package:firstapp/provider/save_favourite_item_provider.dart';
import 'package:firstapp/utils/binding.dart';
import 'package:firstapp/view/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouriteProvider(),
      child: GetMaterialApp(
        initialBinding: Binding(),
        home: ControlView(),
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(brightness: Brightness.dark),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

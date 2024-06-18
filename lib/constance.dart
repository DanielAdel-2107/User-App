import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color primaryColor = const Color(0xff446FAF);

const CACHED_USER_DATA = 'CACHED_USER_DATA';

final String savedItemsTable = 'savedItems';
final String columnAmenties = 'Amenties';
final String columnLocation = 'Location';
final String columnArea = 'area';
final String columnPrice = 'price';
final String columnDownPayment = 'down payment';
final String columnInstallment = 'installment value';
final String columnType = 'type';
final String columnRooms = 'number of rooms';
final String columnBaths = 'number of baths';
final String columnDescription = 'description';
final String columnBrokerEmail = 'broker email';
final String columnBrokerPhone = 'broker phone';
final String columnPaymentType = 'payment type';

const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  scaffoldBackgroundColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  colorScheme: ColorScheme.dark(
    primary: kDarkPrimaryColor,
    secondary: kAccentColor,
  ),
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  scaffoldBackgroundColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  colorScheme: ColorScheme.light(
    primary: kLightPrimaryColor,
    secondary: kAccentColor,
  ),
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);

final brightness =
    WidgetsBinding.instance.platformDispatcher.platformBrightness;

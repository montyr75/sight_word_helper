import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SU {
  static const backgroundColor = Colors.black;
  static const headerColor = Colors.green;
  static final dataColor = Colors.green[200];

  // screen height and width (defaults are the reference dimensions around which everything will scale)
  static double defaultScreenWidth = 800.0;
  static double defaultScreenHeight = 1232.0;
  static double screenWidth = defaultScreenWidth;
  static double screenHeight = defaultScreenHeight;

  // sizes for padding and margin (scaled based on screen width)
  static double sizeXS = 4.0;
  static double sizeS = 6.0;
  static double sizeDefault = 8.0;
  static double sizeM = 12.0;
  static double sizeL = 20.0;
  static double sizeXL = 30.0;
  static double sizeXXL = 40.0;
  static double sizeXXXL = 50.0;

  // screen width fractions
  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;
  static double screenWidthSixth = screenWidth / 6;
  static double screenWidthTenth = screenWidth / 10;

  // padding/margin widgets
  static EdgeInsets paddingAllXS = EdgeInsets.all(sizeXS);
  static EdgeInsets paddingAllS = EdgeInsets.all(sizeS);
  static EdgeInsets paddingAllDefault = EdgeInsets.all(sizeDefault);
  static EdgeInsets paddingAllM = EdgeInsets.all(sizeM);

  // boxes for spacing
  static SizedBox boxXS = SizedBox(width: sizeXS, height: sizeXS);
  static SizedBox boxS = SizedBox(width: sizeS, height: sizeS);
  static SizedBox boxDefault = SizedBox(width: sizeDefault, height: sizeDefault);
  static SizedBox boxM = SizedBox(width: sizeM, height: sizeM);

  static Map<int, double> fontSize;

  static void initialize(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    setScreenAwareFontSize();

    sizeXS = ScreenUtil.instance.setWidth(sizeXS) as double;
    sizeS = ScreenUtil.instance.setWidth(sizeS) as double;
    sizeDefault = ScreenUtil.instance.setWidth(sizeDefault) as double;
    sizeM = ScreenUtil.instance.setWidth(sizeM) as double;
    sizeL = ScreenUtil.instance.setWidth(sizeL) as double;
    sizeXL = ScreenUtil.instance.setWidth(sizeXL) as double;
    sizeXXL = ScreenUtil.instance.setWidth(sizeXXL) as double;
    sizeXXXL = ScreenUtil.instance.setWidth(sizeXXXL) as double;

    paddingAllXS = EdgeInsets.all(sizeXS);
    paddingAllS = EdgeInsets.all(sizeS);
    paddingAllDefault = EdgeInsets.all(sizeDefault);
    paddingAllM = EdgeInsets.all(sizeM);

    boxXS = SizedBox(width: sizeXS, height: sizeXS);
    boxS = SizedBox(width: sizeS, height: sizeS);
    boxDefault = SizedBox(width: sizeDefault, height: sizeDefault);
    boxM = SizedBox(width: sizeM, height: sizeM);

    screenWidthHalf = ScreenUtil.instance.width / 2;
    screenWidthThird = ScreenUtil.instance.width / 3;
    screenWidthFourth = ScreenUtil.instance.width / 4;
    screenWidthFifth = ScreenUtil.instance.width / 5;
    screenWidthSixth = ScreenUtil.instance.width / 6;
    screenWidthTenth = ScreenUtil.instance.width / 10;
  }

  // convenience functions
  static double saWidth(double value) => ScreenUtil.instance.setWidth(value) as double;
  static double saHeight(double value) => ScreenUtil.instance.setHeight(value) as double;

  static ThemeData generateThemeData() {
    return ThemeData(
      primarySwatch: Colors.green,
      accentColor: dataColor,
      scaffoldBackgroundColor: Colors.transparent,
      brightness: Brightness.dark,
      unselectedWidgetColor: Colors.grey,
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: fontSize[24],
            fontFamily: 'Steiner',
          ),
        ),
      ),
      textTheme: TextTheme(
        display4: TextStyle(
          color: headerColor,
          fontSize: fontSize[24],
          fontFamily: 'HeavyMetal2',
        ),
        title: TextStyle(
          color: headerColor,
          fontSize: fontSize[18],
          fontFamily: 'HeavyMetal2',
        ),
        subhead: TextStyle(
          color: dataColor,
          fontSize: fontSize[16],
          fontFamily: 'HeavyMetal5',
        ),
        body1: TextStyle(
          color: dataColor,
          fontSize: fontSize[14],
          fontFamily: 'HeavyMetal5',
        ),
        body2: TextStyle(
          color: dataColor,
          fontSize: fontSize[10],
          fontFamily: 'HeavyMetal5',
        ),
      ),
      buttonTheme: ButtonThemeData(
        height: SU.saHeight(36.0),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        titleTextStyle: TextStyle(
          color: headerColor,
          fontSize: fontSize[24],
          fontFamily: 'HeavyMetal2',
        ),
      ),
    );
  }

  static setScreenAwareFontSize() {
    final Map<int, double> fontTable = {};

    for (int i = 7; i <= 48; i++) {
      fontTable[i] = ScreenUtil.instance.setSp(i) as double;
    }

    fontSize = Map<int, double>.unmodifiable(fontTable);
  }
}
//
//final _fontSize = <int, double>{
//
//};
//
//class fontSize {
//  static double s7 = 7.0;
//  static double s8 = 8.0;
//  static double s9 = 9.0;
//  static double s10 = 10.0;
//  static double s11 = 11.0;
//  static double s12 = 12.0;
//  static double s13 = 13.0;
//  static double s14 = 14.0;
//  static double s15 = 15.0;
//  static double s16 = 16.0;
//  static double s17 = 17.0;
//  static double s18 = 18.0;
//  static double s19 = 19.0;
//  static double s20 = 20.0;
//  static double s21 = 21.0;
//  static double s22 = 22.0;
//  static double s23 = 23.0;
//  static double s24 = 24.0;
//  static double s25 = 25.0;
//  static double s26 = 26.0;
//  static double s27 = 27.0;
//  static double s28 = 28.0;
//  static double s29 = 29.0;
//  static double s30 = 30.0;
//  static double s36 = 36.0;
//
//  static setScreenAwareFontSize() {
//    s7 = ScreenUtil.instance.setSp(7.0);
//    s8 = ScreenUtil.instance.setSp(8.0);
//    s9 = ScreenUtil.instance.setSp(9.0);
//    s10 = ScreenUtil.instance.setSp(10.0);
//    s11 = ScreenUtil.instance.setSp(11.0);
//    s12 = ScreenUtil.instance.setSp(12.0);
//    s13 = ScreenUtil.instance.setSp(13.0);
//    s14 = ScreenUtil.instance.setSp(14.0);
//    s15 = ScreenUtil.instance.setSp(15.0);
//    s16 = ScreenUtil.instance.setSp(16.0);
//    s17 = ScreenUtil.instance.setSp(17.0);
//    s18 = ScreenUtil.instance.setSp(18.0);
//    s19 = ScreenUtil.instance.setSp(19.0);
//    s20 = ScreenUtil.instance.setSp(20.0);
//    s21 = ScreenUtil.instance.setSp(21.0);
//    s22 = ScreenUtil.instance.setSp(22.0);
//    s23 = ScreenUtil.instance.setSp(23.0);
//    s24 = ScreenUtil.instance.setSp(24.0);
//    s25 = ScreenUtil.instance.setSp(25.0);
//    s26 = ScreenUtil.instance.setSp(26.0);
//    s27 = ScreenUtil.instance.setSp(27.0);
//    s28 = ScreenUtil.instance.setSp(28.0);
//    s29 = ScreenUtil.instance.setSp(29.0);
//    s30 = ScreenUtil.instance.setSp(30.0);
//    s36 = ScreenUtil.instance.setSp(36.0);
//  }
//}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyColors {
  static Color eZMockUpMyrtleYellow = const Color.fromARGB(255, 249, 201, 76);
  static Color eZMockUpPastelOrange = const Color.fromARGB(255, 249, 179, 76);
  static Color eZMockUpBlanchedAlmond = const Color.fromARGB(255, 137, 138, 141);
  static Color eZMockUpOldLace = const Color.fromARGB(255, 255, 246, 227);
  static Color eZMockUpWestSideOrange = const Color.fromARGB(255, 255, 144, 18);
  static Color eZMockUpMetallicOrange = const Color.fromARGB(255, 218, 99, 23);
  static Color eZMockUpButtonColor = const Color.fromARGB(255, 249, 179, 76);
  static Color eZMockUpButtonColorText = Colors.white;

  static Color eZMockUpGrey130 = const Color.fromARGB(255, 130, 130, 130);
  static Color eZMockUpGrey169 = const Color.fromARGB(255, 169, 169, 169);
  static Color eZMockUpGrey200 = const Color.fromARGB(255, 200, 200, 200);
  static Color eZMockUpGrey230 = const Color.fromARGB(255, 230, 230, 230);
  static Color eZMockUpGrey243 = const Color.fromARGB(255, 243, 243, 243);



  static Color noBgPicture = const Color.fromARGB(255, 237, 237, 237);
  static Color disableButton = const Color.fromARGB(255, 240, 240, 240) ;
  static Color disableTextButton = const Color.fromARGB(255, 150, 150, 150) ;
  static Color iconPopupMenu = const Color.fromARGB(255, 14, 125, 227) ;

}

class MyPadding{
  static double paddingContent = 5.w;
  static double paddingBottomScreen = 3.h;
}

class MyFontSize{
  static double fontSizeShowBottomSheet = 12.5.sp;
  static double sizeNormal = 11.sp;
  //static double sizeTopic = Global.deviceHeight * 0.021;
  static double sizeTopic = 12.5.sp;
}

extension HexColor on Color {

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
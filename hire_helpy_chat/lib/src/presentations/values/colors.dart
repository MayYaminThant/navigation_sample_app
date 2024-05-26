part of values;

class AppColors {
  static const Color primaryColor = Color(0xFFFF8E03);
  static const Color secondaryColor = Color(0xFF03CBFB);
  static const Color cardColor = Color(0xffD9D9D9);
  static const Color articleBackgroundColor = Color(0xffA8A6A6);
  static const Color backgroundGrey = Color(0xfff2f2f2);
  static const Color rednotification = Color(0xffD80027);

  //Blue
  static const Color skyBlue = Color(0xff82A1FE);
  static const Color brandBlue = Color(0xff03CBFB);

  //Grey
  static const Color primaryGrey = Color(0xffBEBEBE);
  static const Color secondaryGrey = Color(0xffA8A6A6);
  static const Color greyShade2 = Color(0xff595959);
  static const Color greyBg = Color(0xffF2F2F2);

  //White
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteShade1 = Color(0xFFF6F6F6);
  static const Color whiteShade2 = Color(0xFFF8F9FD);

  //Black
  static const Color black = Color(0xFF000000);
  static const Color blackShade1 = Color(0xFF3B3870);
  static const Color blackShade2 = Color(0xFF2D3041);
  static const Color blackShade3 = Color(0xFF797C82);
  static const Color blackShade4 = Color(0xFF626061);
  static const Color blackShade5 = Color(0xFF323345);
  static const Color blackShade6 = Color(0xFF51515E);
  static const Color blackShade7 = Color(0xFF2F2F2F);
  static const Color blackShade8 = Color(0xFF040404);
  static const Color blackShade9 = Color(0xFF767676);
  static const Color blackShade10 = Color(0xFF606060);
  static const Color darkModeColor = Color(0xFF323337);

  //Green
  static const Color green = Color(0xff06B506);
  static const Color lightGreen = Color(0xffAACC73);
  static const Color secondaryGreen = Color(0xff00FF00);

  static Color blueGray10019 = fromHex('#19d9d9d9');
  static Color deepOrange200 = fromHex('#ffb6a0');
  static Color indigoA100Da = fromHex('#da768aff');
  static Color pink50 = fromHex('#ffcaf1');

  //Purple
  static Color purple = const Color(0xFFBACBFF);

  //Pink
  static const Color pink = Color(0xffFC77DA);

  //Yello
  static const Color yellow = Colors.yellow;

  //Red
  static const Color red = Colors.red;

  //Convert HexString to color
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

import 'package:flutter/material.dart';
import 'package:qn_base_core/utils/ui_utils.dart';

class UI {
  ///默认设计稿尺寸（单位 dp or pt）
  static double designW = 375.0;
  static double designH = 812.0;
  static double designD = 2.0;
  static const Color clMain = Color(0xFF007AFF);
  static const Color clFade = Color(0xFF888888);

  static const Color clFF = Color(0xFFffffff);
  static const Color cl99 = Color(0xFF999999);
  static const Color cl66 = Color(0xFF666666);
  static const Color cl33 = Color(0xFF333333);

  static double dp8 = ScreenUtil.getInstance().getWidth(8);
  static double dp16 = ScreenUtil.getInstance().getWidth(16);
  static double dp24 = ScreenUtil.getInstance().getWidth(24);
  static double dp48 = ScreenUtil.getInstance().getWidth(48);

  static double font_8 = ScreenUtil.getInstance().getSp(8);
  static double font_10 = ScreenUtil.getInstance().getSp(10);
  static double font_12 = ScreenUtil.getInstance().getSp(12);
  static double font_14 = ScreenUtil.getInstance().getSp(14);
  static double font_16 = ScreenUtil.getInstance().getSp(16);
  static double font_17 = ScreenUtil.getInstance().getSp(17);
  static double font_18 = ScreenUtil.getInstance().getSp(18);
  static double font_20 = ScreenUtil.getInstance().getSp(20);
  static double font_28 = ScreenUtil.getInstance().getSp(28);

  static EdgeInsets pd16 = EdgeInsets.all(dp16);

  static TextStyle tx12_99 = TextStyle(
    fontSize: font_12,
    color: cl99,
  );

  static TextStyle tx14_33 = TextStyle(
    fontSize: font_14,
    color: cl33,
  );
  static TextStyle tx14_99 = TextStyle(
    fontSize: font_14,
    color: cl99,
  );

  static TextStyle tx16_33 = TextStyle(
    fontSize: font_16,
    color: cl33,
  );
  static TextStyle tx16_99 = TextStyle(
    fontSize: font_16,
    color: cl99,
  );
  static TextStyle tx18_33 = TextStyle(
    fontSize: font_18,
    color: cl33,
  );
  static TextStyle tx18_99 = TextStyle(
    fontSize: font_18,
    color: cl99,
  );
  static TextStyle tx18_main = TextStyle(
    fontSize: font_18,
    color: clMain,
  );


}

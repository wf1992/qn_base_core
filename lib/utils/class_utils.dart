import 'package:flutter/material.dart';

class ClassUtils{
     ///获取类名
  static String getClassName(BuildContext _buildContext) {
    if (_buildContext == null) {
      return "UnKnow Context";
    }
    String className = _buildContext.toString();
    if (className == null) {
      return "UnKnow className";
    }
    className = className.substring(0, className.indexOf("(")).toString();
    return className;
  }
}
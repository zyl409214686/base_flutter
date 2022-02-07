

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {

  // iOS浅色主题
  static final ThemeData kIOSTheme = ThemeData( brightness: Brightness.light, accentColor: Colors.white,
      primaryColor: Colors.blue,
      iconTheme:IconThemeData(color: Colors.grey),
      textTheme: TextTheme(body1: TextStyle(color: Colors.black)));
  static final ThemeData kAndroidTheme = ThemeData( brightness: Brightness.dark,//深色主题
      accentColor: Colors.black,//(按钮)Widget前景色为黑色
      primaryColor: Colors.cyan,//主题色Wie青色
      iconTheme:IconThemeData(color: Colors.blue),//icon主题色为蓝色
      textTheme: TextTheme(body1: TextStyle(color: Colors.red)));//文本主题色为红色);

  ThemeData curTheme = kAndroidTheme;

  ThemeData updateTheme(){
    ThemeData theme;
    if(curTheme == kAndroidTheme)
      theme = kIOSTheme;
    else
      theme = kAndroidTheme;
    curTheme = theme;
    notifyListeners();
  }
}
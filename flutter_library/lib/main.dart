import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/view_model/ThemeModel.dart';
import 'package:provider/provider.dart';

import 'citys_widget.dart';
import 'hot_weiget.dart';
import 'mine_widget.dart';
import 'movies_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  int _selectIndex = 0;
  final _widgetItems = [HotWeiget(), MoviesWeiget(), MineWeiget()];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
        create: (context) => ThemeModel(),
        child: Consumer<ThemeModel>(
          builder: (context, themeModel, child){
            return MaterialApp(
              home: Scaffold(
                body: SafeArea(
                    child: Center(
                      child: _widgetItems[_selectIndex],
                    )),
                bottomNavigationBar: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.school), label: "热映"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.panorama_fish_eye), label: "找片"),
                    BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的"),
                  ],
                  currentIndex: _selectIndex,
                  fixedColor: Colors.black,
                  type: BottomNavigationBarType.fixed,
                  onTap: _onItemTapped,
                ),
              ),
              routes: {
                '/Citys': (context) => CitysWidget(),
              },
              theme: themeModel.curTheme,
            );
          },
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}

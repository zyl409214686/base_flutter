import 'package:flutter/material.dart';

import 'citys_widget.dart';
import 'hot_weiget.dart';
import 'mine_widget.dart';
import 'movies_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: MyHomePage(title: 'Flutter Demo Home Page'),
  //   );
  // }

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
    // String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   platformVersion = await FlutterDouban.platformVersion;
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }
    // print("platformVersion:"+platformVersion);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }
  int _selectIndex = 0;
  final _widgetItems = [HotWeiget(), MoviesWeiget(), MineWeiget()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('豆瓣电影'),
        // ),

        body: SafeArea(
            child:Center(
            child: _widgetItems[_selectIndex],
        )),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.school), label: "热映"),
            BottomNavigationBarItem(
                icon: Icon(Icons.panorama_fish_eye), label: "找片"),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: "我的"),
          ],
          currentIndex: _selectIndex,
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
      routes: {
        '/Citys':(context) => CitysWidget(),
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}

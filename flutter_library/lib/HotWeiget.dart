import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HotMoviesListWidget.dart';

class HotWeiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotWeigetState();
  }
}

class HotWeigetState extends State<HotWeiget> {
  String curCity = "";
  final SP_CUR_CITY_KEY = 'curCity';

  @override
  Widget build(BuildContext context) {
    // curCity = ModalRoute.of(context).settings.arguments;
    void _jumpToCitysWidget() async {
      var selectCity = await Navigator.pushNamed(
          context, '/Citys', arguments: curCity);
      if (selectCity == null) {
        print("selectCity is null");
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(SP_CUR_CITY_KEY, selectCity.toString());
      setState(() {
        curCity = selectCity.toString();
        print("curCity:" + selectCity.toString());
      });
    }
    if(curCity == null || curCity.isEmpty){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 60,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(children: <Widget>[
                GestureDetector(
                  child: Text(
                    curCity,
                    style: TextStyle(fontSize: 16),),
                  onTap: () {
                    _jumpToCitysWidget();
                  },
                ),
                Icon(Icons.arrow_drop_down),
                Expanded(
                  flex: 1,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        hintText: '\uE0ad 电影 / 电视剧 / 影人',
                        hintStyle: TextStyle(
                            fontFamily: 'MaterialIcons', fontSize: 16),
                        contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        filled: true,
                        fillColor: Colors.black12),
                  ),
                )
              ])),
          Expanded(child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 50),
                  child: TabBar(
                    unselectedLabelColor: Colors.black12,
                    labelColor: Colors.black87,
                    indicatorColor: Colors.black87,
                    tabs: <Widget>[Tab(text: '正在热映'), Tab(text: '即将热映')],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        HotMoviesListWidget(),
                        Center(
                          child: Text('即将热映'),
                        )
                      ],
                    )
                )
              ],
            ),
          ))
        ]);
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final prefs = await SharedPreferences.getInstance();
    String city = prefs.getString(SP_CUR_CITY_KEY);
    if (city != null && city.isNotEmpty) {
      setState(() {curCity = city;});
    }
    else{
      setState(() {
        curCity = '南极洲';
      });
    }
  }
}

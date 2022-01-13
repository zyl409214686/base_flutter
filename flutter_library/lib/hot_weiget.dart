import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hot_movies_list_widget.dart';

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
    return  CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight:50,
            floating: true,
            backgroundColor: Colors.white,
            flexibleSpace: Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                alignment: Alignment.bottomCenter,
                child: Row(children: <Widget>[
                  GestureDetector(
                    child: Text(
                      curCity,
                      style: TextStyle(fontSize: 16,
                      color:Colors.black),),
                    onTap: () {
                      _jumpToCitysWidget();
                    },
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.black,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black12,
                      ),
                      child: Center(
                        child:IntrinsicWidth(
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: '电影 / 电视剧 / 影人',
                              hintStyle: TextStyle(
                                  fontFamily: 'MaterialIcons', fontSize: 16),
                              contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          )
                        )
                      )
                    ),
                  )
                ])),
          ),
          HotMoviesListWidget()
          // Expanded(child: DefaultTabController(
          //   length: 2,
          //   child: Column(
          //     children: <Widget>[
          //       Container(
          //         constraints: BoxConstraints.expand(height: 50),
          //         child: TabBar(
          //           unselectedLabelColor: Colors.black12,
          //           labelColor: Colors.black87,
          //           indicatorColor: Colors.black87,
          //           tabs: <Widget>[Tab(text: '正在热映'), Tab(text: '即将热映')],
          //         ),
          //       ),
          //       Expanded(
          //           child: TabBarView(
          //             children: <Widget>[
          //               HotMoviesListWidget(),
          //               Center(
          //                 child: Text('即将热映'),
          //               )
          //             ],
          //           )
          //       )
          //     ],
          //   ),
          // ))
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

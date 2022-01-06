import 'package:flutter/material.dart';

class MoviesWeiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MoviesWeigetState();
  }
}


class MoviesWeigetState extends State<MoviesWeiget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 60,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(children: <Widget>[
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
                    tabs: <Widget>[Tab(text:'电影'), Tab(text: '电视')],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Center(
                            child:Text('电影')
                        ),
                        Center(
                          child: Text('电视'),
                        )
                      ],
                    )
                )
              ],
            ),
          ))
        ]);
  }

}
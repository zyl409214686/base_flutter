import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'HotMoviesItemWidget.dart';
import 'bean/HotMovie.dart';
import 'config/httpHeaders.dart';

class HotMoviesListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotMoviesListWidgetState();
  }
}

class HotMoviesListWidgetState extends State<HotMoviesListWidget> {
  List<HotMovie> hotMovies = <HotMovie>[];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index){
          return HotMoviesItemWidget(hotMovies[index]);
        },
        separatorBuilder: (context, index){
          return Divider(
            height: 1,
            color: Colors.black26,
          );
        },
        itemCount: hotMovies.length);
  }

  @override
  void initState() {
    super.initState();
    // var data = HotMovieData('反贪风暴4', 6.3, '林德禄', '古天乐/郑嘉颖/林苗', 29013,
    //     'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551353482.webp');
    setState(() {
       _getData();
    });
  }

  void _getData() async {
    List<HotMovie> serverDataList = [];
    var response = await http.get(Uri.parse('https://m.maoyan.com/ajax/movieOnInfoList'), headers: httpHeaders);
    // var response = await http.get('https://pagead2.googlesyndication.com/getconfig/sodar?sv=200&tid=gda&tv=r20210915&st=env', headers: httpHeaders);

    print('response.statusCode:'+response.statusCode.toString());
    //成功获取数据
    if (response.statusCode == 200) {
      print('response.body:'+response.body);
      var responseJson = json.decode(response.body);
      for (dynamic data in responseJson['movieList']) {
        print("data:"+ data.toString());
        HotMovie hotMovieData = HotMovie.fromJson(data);
        serverDataList.add(hotMovieData);
      }
      setState(() {
        hotMovies = serverDataList;
      });
    }
  }
}

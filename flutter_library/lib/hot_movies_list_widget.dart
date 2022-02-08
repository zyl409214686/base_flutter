import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_library/common/utils/log_util.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;

import 'hot_movies_item_widget.dart';
import 'bean/HotMovie.dart';
import 'config/httpHeaders.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

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
    return SliverList(delegate: SliverChildBuilderDelegate(
        (context, index) => HotMoviesItemWidget(hotMovies[index]),
        childCount: hotMovies.length)
    );
    // return ListView.separated(
    //     itemBuilder: (context, index){
    //       return HotMoviesItemWidget(hotMovies[index]);
    //     },
    //     separatorBuilder: (context, index){
    //       return Divider(
    //         height: 1,
    //         color: Colors.black26,
    //       );
    //     },
    //     itemCount: hotMovies.length);
  }

  @override
  Future<void> initState() {
    super.initState();

    // var data = HotMovieData('反贪风暴4', 6.3, '林德禄', '古天乐/郑嘉颖/林苗', 29013,
    //     'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551353482.webp');
    getMoviesForLocal();
    _getData();
  }

  void getMoviesForLocal() async {
    // Future.delayed(Duration(seconds:3), () => "Hello") .then((x) => "$x 2019");
      initDataBase().then((value) {
          value.query('Movies').then((value) {
            LogUtil.d("query Movies value: ${value.length}");
            setState((){
              hotMovies = List.generate(value.length, (i)=>HotMovie.fromJson(value[i]));
            });
          });
      });
  }



  // void getHttp() async {
  //   try {
  //     var response = await Dio().get('http://www.google.com');
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void _getData() async {
    List<HotMovie> serverDataList = [];
    // var response = await http.get(Uri.parse('https://m.maoyan.com/ajax/movieOnInfoList'), headers: httpHeaders);
    var response = await Dio().get('https://m.maoyan.com/ajax/movieOnInfoList',
        options: Options(headers: httpHeaders));
    print('response.statusCode:'+response.statusCode.toString());
    //成功获取数据
    if (response.statusCode == 200) {
      for (dynamic data in response.data['movieList']) {
        HotMovie hotMovieData = HotMovie.fromJson(data);
        serverDataList.add(hotMovieData);
      }
      setState(() {
        hotMovies = serverDataList;
      });
      Database database = await initDataBase();
      for(int i=0; i<hotMovies.length; i++){
        database.insert("Movies", hotMovies[i].toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  Future<Database> initDataBase() async {
    LogUtil.d("databasepath:" + join(await getDatabasesPath(), 'movies.db'));
    var db = await openDatabase(
        join(await getDatabasesPath(), 'movies.db'), version: 1, onCreate: (Database db, int version) async{
      await db.execute(
          'CREATE TABLE Movies (id INTEGER PRIMARY KEY, img TEXT, nm TEXT, sc TEXT, showInfo TEXT, '
              'haspromotionTag INTEGER, version TEXT, preShow INTEGER, globalReleased INTEGER,'
              'wish INTEGER, star TEXT, showst INTEGER, wishst INTEGER, comingTitle TEXT, rt TEXT)');
    });
    return db;
  }
    // final Future database = openDatabase( join(await getDatabasesPath(), 'students_database.db'), onCreate: (db, version)=>db.execute("CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER)"), onUpgrade: (db, oldVersion, newVersion){ //dosth for migration
    //   }, version: 1,);
    // }
}

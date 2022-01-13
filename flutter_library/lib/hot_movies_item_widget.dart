import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bean/HotMovie.dart';


class HotMoviesItemWidget extends StatefulWidget {
  HotMovie mHotMoveData;

  HotMoviesItemWidget(this.mHotMoveData, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HotMoviesItemWidgetState();
  }
}

class HotMoviesItemWidgetState extends State<HotMoviesItemWidget> {
  static const methodChannel = const MethodChannel('flutter.doubanmovie/buy');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 160,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            widget.mHotMoveData.img.toString().replaceFirst('w.h/', '').toString(),
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mHotMoveData.nm??"",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.mHotMoveData.sc.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                   widget.mHotMoveData.showInfo??"",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  '主演：' + (widget.mHotMoveData.star??""),
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          )),
          SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.mHotMoveData.wish.toString() + '人看过',
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
                OutlinedButton(
                  onPressed: () {
                    methodChannel.invokeMethod('buyTicket', '购买' + (widget.mHotMoveData.comingTitle??"") + '电影票一张');
                  },
                  child: const Text(
                    '购票',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

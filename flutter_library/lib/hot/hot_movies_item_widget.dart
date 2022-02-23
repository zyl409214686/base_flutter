import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bean/HotMovie.dart';


class HotMoviesItemWidget extends StatefulWidget {
  HotMovie mHotMoveData;
  bool showBorder;
  HotMoviesItemWidget(this.mHotMoveData, this.showBorder);

  @override
  State<StatefulWidget> createState() {
    return HotMoviesItemWidgetState();
  }
}

class HotMoviesItemWidgetState extends State<HotMoviesItemWidget> {
  static const methodChannel = const MethodChannel('flutter.doubanmovie/buy');
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Column(
             children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   ExtendedImage.network(
                       widget.mHotMoveData.img.toString().replaceFirst('w.h/', '').toString(),
                       width: 120,
                       height:  80,
                       fit: BoxFit.contain,
                       cache: true,
                       loadStateChanged: (ExtendedImageState state) {
                         switch (state.extendedImageLoadState) {
                           case LoadState.completed:
                             return state.completedWidget;
                             break;
                           default:
                             return Image.asset(
                               "assets/item_placeholder.png",
                               width: 120,
                               height: 80,
                               fit: BoxFit.contain,
                             );
                             break;
                         }
                       }),

                   Expanded(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           widget.mHotMoveData.nm??"",
                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         ),
                         Text(
                           '猫眼评分：' + widget.mHotMoveData.sc.toString(),
                           style: const TextStyle(fontSize: 14, color: Colors.black54),
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         ),
                         Text(
                           widget.mHotMoveData.showInfo??"",
                           style: const TextStyle(fontSize: 14, color: Colors.black54),
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         ),
                         Text(
                           '主演：' + (widget.mHotMoveData.star??""),
                           style: const TextStyle(fontSize: 14, color: Colors.black54),
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         ),
                       ],
                     ),
                   ),
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
               widget.showBorder ? Padding(padding: EdgeInsets.only(left: 120), child: Divider(color: Colors.blueGrey),) : Container()
             ],
          )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_library/view_model/ThemeModel.dart';
import 'package:provider/provider.dart';

class MineWeiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MineWeigetState();
  }
}


class MineWeigetState extends State<MineWeiget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: GestureDetector(
          child: Text("夜间模式切换", style: TextStyle(color: Colors.red, backgroundColor: Colors.amber),),
          onTap: (){
            var model = Provider.of<ThemeModel>(context, listen: false);
            model.updateTheme();
          }
      )
      // child: Text("我的"),

    );
  }

}
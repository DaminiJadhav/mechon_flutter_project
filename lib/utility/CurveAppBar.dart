import 'package:flutter/material.dart';
import 'package:mechon/utility/MyColor.dart';

class CurveAppBar{

  static getAppbar(String title,BuildContext context){
    return AppBar(
      title: Center(child: Text(title)),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.vertical(
            bottom: new Radius.elliptical(
                MediaQuery.of(context).size.width, 60.0)),
      ),
      // leading: Icon(Icons.arrow_back_ios_rounded,color: MyColors.white,size: 10,),
    );
  }


}
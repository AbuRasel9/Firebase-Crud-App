import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utils{
  void toastMessage(String msg,Color backgroundColor,Color textColor){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0
    );
  }
}
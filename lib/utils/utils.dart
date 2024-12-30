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

  String getOtpErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-phone-number':
        return "The phone number entered is invalid. Please check and try again.";
      case 'too-many-requests':
        return "Too many requests have been made. Please wait and try again later.";
      case 'quota-exceeded':
        return "The SMS quota for this project has been exceeded. Try again later.";
      case 'operation-not-allowed':
        return "Phone sign-in is not enabled. Please contact support.";
      case 'session-expired':
        return "The verification code has expired. Please request a new code.";
      case 'invalid-verification-code':
        return "The verification code entered is incorrect. Please try again.";
      default:
        return "An unknown error occurred. Please try again later.";
    }
  }

}
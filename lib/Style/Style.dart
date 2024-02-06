import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
const colorRed= Color.fromRGBO(231, 28, 36, 1);
const colorGreen= Color.fromRGBO(33, 191, 115, 1);
const colorWhite= Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue= Color.fromRGBO(44, 62, 80, 1);

SliverGridDelegateWithFixedCrossAxisCount productGridViewStyle(){
  return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      mainAxisExtent: 250,
  );
}
screenBackGround(context){
  return SvgPicture.asset(
    "images/screen-back.svg",
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fit: BoxFit.cover,
  );
}
void errorToast(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorRed,
      textColor: colorWhite,
      fontSize: 16.0
  );
}
void successToast(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorGreen,
      textColor: colorWhite,
      fontSize: 16.0
  );
}
DecoratedBox appDropDownStyle(child) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: colorWhite,
      border: Border.all(
        color: colorWhite,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: child,
    ),
  );
}

InputDecoration appInputDecoration(label){
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 1,
      ),
    ),
    filled: true,
    fillColor: colorWhite,
    contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: colorWhite,
        width: 0,
      ),
    ),
    border: OutlineInputBorder(),
    labelText: label
  );
}

ButtonStyle appButtonStyle(){
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

Ink successButtonChild(buttonText){
  return Ink(
    decoration: BoxDecoration(
      color: colorGreen,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(buttonText,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15
        ),
      ),
    ),
  );
}
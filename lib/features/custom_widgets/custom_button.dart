import 'package:flutter/material.dart';

Widget customButton({
  double? height,
  double? width,
  bool? highlightButton,
  FontWeight? fontWeight,
  required String text,required void Function() onTap,
})=>SizedBox(
  height: height,
  width: width,
  child:   TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
      backgroundColor:highlightButton==true?const Color(0xff1DA1F2): const Color(0xffEDF8FF),),
    child:  Text(
      text,
      style: TextStyle(
        color: highlightButton==true?const Color(0xffffffff): const Color(0xff1DA1F2),
        fontSize: 14,
        fontWeight: fontWeight??FontWeight.w500,
        fontFamily: 'Roboto',
      ),
    ),
  ),
);
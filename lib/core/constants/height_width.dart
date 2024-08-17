import 'package:flutter/material.dart';
// height
const kHeight5 = SizedBox(height: 5,);
const kHeight10 = SizedBox(height: 10,);
const kHeight15 = SizedBox(height: 15,);
const kHeight20 = SizedBox(height: 20,);
const kHeight25 = SizedBox(height: 25,);
const kHeight30 = SizedBox(height: 30,);
const kHeight35 = SizedBox(height: 35,);
const kHeight40 = SizedBox(height: 40,);
const kHeight45 = SizedBox(height: 45,);
const kHeight50 = SizedBox(height: 50,);
const kHeight55 = SizedBox(height: 55,);
const kHeight60 = SizedBox(height: 60,);
const kHeight65 = SizedBox(height: 65,);
const kHeight70 = SizedBox(height: 70,);
// width
const kWidth5 = SizedBox(width: 5,);
const kWidth10 = SizedBox(width: 10,);
const kWidth15 = SizedBox(width: 15,);
const kWidth20 = SizedBox(width: 20,);
const kWidth25 = SizedBox(width: 25,);
const kWidth30 = SizedBox(width: 30,);
const kWidth35 = SizedBox(width: 35,);
const kWidth40 = SizedBox(width: 40,);
const kWidth45 = SizedBox(width: 45,);
const kWidth50 = SizedBox(width: 50,);
const kWidth55 = SizedBox(width: 55,);
const kWidth60 = SizedBox(width: 60,);
const kWidth65 = SizedBox(width: 65,);
const kWidth70 = SizedBox(width: 70,);
const zeroMeasuredWidget = SizedBox(height: 0,width: 0,);
// Screen Height
double screenHeight({required BuildContext context}){
  return MediaQuery.of(context).size.height;
}

// Screen Width
double screenWidth({required BuildContext context}){
  return MediaQuery.of(context).size.width;
}

// Screen Size
Size screenSize({required BuildContext context}){
  return MediaQuery.of(context).size;
}


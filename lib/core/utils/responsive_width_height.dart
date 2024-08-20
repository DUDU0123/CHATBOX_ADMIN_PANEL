import 'package:flutter/material.dart';

double getResponsiveWidth(BuildContext context, double baseWidth) {
  return baseWidth * (MediaQuery.of(context).size.width / 375);
}

double getResponsiveHeight(BuildContext context, double baseHeight) {
  return baseHeight * (MediaQuery.of(context).size.height / 812);
}

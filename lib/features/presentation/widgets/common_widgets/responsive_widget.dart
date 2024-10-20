import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_filed_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

double responsiveWidth(BuildContext context, double maxWidth) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth * 0.8 < maxWidth ? screenWidth * 0.8 : maxWidth;
}

Widget responsiveField({
  required TextEditingController controller,
  required TextInputType? keyboardType,
  required String hintText,
  required BuildContext context,
  double? fontSize,
  Color? containerColor,
  Color? textColor,
  Color? borderColor,
  void Function(String)? onChanged,
}) {
  return Container(
    height: 50,
    width: responsiveWidth(context, 400),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: borderColor ?? kTransparent,
      ),
      color: containerColor ?? kWhite,
    ),
    child: Center(
      child: TextFieldCommon(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        cursorColor: textColor ?? kBlack,
        hintText: hintText,
        border: InputBorder.none,
        style: GoogleFonts.play(
          color: textColor ?? kBlack,
          fontWeight: FontWeight.normal,
          fontSize: responsiveFontSize(
            context: context,
            baseSize: fontSize ?? 16,
          ),
        ),
      ),
    ),
  );
}

Widget responsiveButton(
    {required BuildContext context,
    required String buttontext,
    required Color buttonColor,
    required double buttonFontSize,
    required double buttonWidth,
    required void Function()? onTap,
    BoxBorder? border,
    Widget? leadingWidget,
    double? height,
    Color? textColor}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: responsiveWidth(context, buttonWidth),
      child: Container(
        height: height ?? 40,
        decoration: BoxDecoration(
          border: border,
          color: buttonColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingWidget ?? zeroMeasuredWidget,
              kWidth5,
              TextWidgetCommon(
                text: buttontext,
                fontSize: responsiveFontSize(
                  context: context,
                  baseSize: buttonFontSize,
                ),
                fontWeight: FontWeight.bold,
                textColor: textColor ?? kWhite,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

double responsiveFontSize({
  required BuildContext context,
  required double baseSize,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double scaleFactor = screenWidth / 1440;
  return baseSize * scaleFactor.clamp(0.8, 1.2);
}

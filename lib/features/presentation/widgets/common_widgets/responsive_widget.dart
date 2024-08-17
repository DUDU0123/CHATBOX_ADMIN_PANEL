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

Widget responsiveTextField({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
  required TextInputType? keyboardType,
}) {
  return SizedBox(
    width: responsiveWidth(context, 400),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kWhite,
      ),
      child: Center(
        child: TextFieldCommon(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.center,
          cursorColor: kBlack,
          hintText: hintText,
          border: InputBorder.none,
          style: GoogleFonts.play(
            color: kBlack,
            fontWeight: FontWeight.normal,
            fontSize: responsiveFontSize(
              context: context,
              baseSize: 16,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget responsiveButton({
  required BuildContext context,
  required String buttontext,
  required Color buttonColor,
  required double buttonFontSize,
  required double buttonWidth,
  required void Function()? onTap,
  Widget? leadingWidget,
  double? height,
  Color? textColor
}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: responsiveWidth(context, buttonWidth),
      child: Container(
        height: height??40,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingWidget??zeroMeasuredWidget,
              kWidth5,
              TextWidgetCommon(
                text: buttontext,
                fontSize: responsiveFontSize(
                  context: context,
                  baseSize: buttonFontSize,
                ),
                fontWeight: FontWeight.bold,
                textColor: textColor?? kWhite,
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

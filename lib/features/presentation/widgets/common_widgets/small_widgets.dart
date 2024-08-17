import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

Widget emptyShowWidget({required BuildContext context, required String text}) {
  return SizedBox(
    width: screenWidth(context: context),
    height: screenHeight(context: context),
    child: Center(
      child: SizedBox(
        width: 250,
        child: TextWidgetCommon(
          textAlign: TextAlign.center,
          text: text,
          textColor: kWhite,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ),
  );
}

Widget commonProfileDefaultIconCircularCotainer(
    {required BuildContext context, double? containerConstraint}) {
  return Container(
    decoration:const BoxDecoration(
      color: kBlack,
      shape: BoxShape.circle,
    ),
    width: containerConstraint ?? 50,
    height: containerConstraint?? 50,
    child: const Center(
      child: Icon(
        Icons.person,
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

void commonSnackBarWidget({
  required BuildContext context,
  required String contentText,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextWidgetCommon(
        textAlign: TextAlign.center,
        text: contentText,
        textColor: kWhite,
      ),
      width: MediaQuery.of(context).size.width * 0.6, // Adjust this value as needed
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      backgroundColor: kGreenBlack,
    ),
  );
}
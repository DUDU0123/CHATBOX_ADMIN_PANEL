import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/common_snackbar_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

class AdminAuthMethods{
  static Future<dynamic> forgotEmailDialogBox({
  required BuildContext context,
  required TextEditingController forgotPasswordController,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: kGreenBlack,
        title: TextWidgetCommon(
          text: 'Reset password',
          fontWeight: FontWeight.w400,
          fontSize: responsiveFontSize(
            context: context,
            baseSize: 18,
          ),
          textColor: kWhite,
        ),
        actions: [
          responsiveTextField(
            context: context,
            hintText: "Enter email",
            controller: forgotPasswordController,
            keyboardType: TextInputType.emailAddress,
          ),
          kHeight10,
          responsiveButton(
            onTap: () {
              log("Button Pressed forgot password");
              Navigator.pop(context);
              commonSnackBarWidget(context: context, contentText: "Email sent for password reset");
            },
            buttonWidth: 100,
            buttonColor: kOrange,
            buttonFontSize: 16,
            buttontext: "Done",
            context: context,
          ),
        ],
      );
    },
  );
}

}
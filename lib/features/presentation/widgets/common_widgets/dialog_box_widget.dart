import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

void normalDialogBoxWidget({
  required BuildContext context,
  required String title,
  required String subtitle,
  required void Function()? onPressed,
  required String actionButtonName,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return alertDialog(
        context: context,
        title: title,
        content: TextWidgetCommon(
          text: subtitle,
          fontSize: responsiveFontSize(context: context, baseSize: 16),
        ),
        onPressed: onPressed,
        actionButtonName: actionButtonName,
      );
    },
  );
}

Widget alertDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  required void Function()? onPressed,
  required String actionButtonName,
}) {
  return AlertDialog(
    title: TextWidgetCommon(
      text: title,
      fontSize: responsiveFontSize(context: context, baseSize: 20),
      fontWeight: FontWeight.bold,
    ),
    actions: dialogBoxActionButtons(
      context: context,
      onPressed: onPressed,
      actionButtonName: actionButtonName,
    ),
    content: content,
  );
}

List<Widget> dialogBoxActionButtons(
    {required BuildContext context,
    required void Function()? onPressed,
    required String actionButtonName}) {
  return [
    TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const TextWidgetCommon(
        text: "Cancel",
        textColor: kLightGreenColor,
      ),
    ),
    TextButton(
      onPressed: onPressed,
      child: TextWidgetCommon(
        text: actionButtonName,
        textColor: kLightGreenColor,
      ),
    ),
  ];
}
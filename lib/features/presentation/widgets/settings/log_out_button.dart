import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/utils/common_db_functions.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/admin_login/admin_login_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/settings_small_widgets.dart';

ElevatedButton logOutButton({
  required bool ismounted,
  required BuildContext context,
}) {
  return ElevatedButton.icon(
    onPressed: () {
      logOutMethod(ismounted: ismounted, context: context,);
    },
    style: buttonStyle(),
    icon: const Icon(
      Icons.power_settings_new_rounded,
      color: kBlack,
    ),
    label: TextWidgetCommon(
      text: 'Log Out',
      fontWeight: FontWeight.bold,
      textColor: kBlack,
      fontSize: responsiveFontSize(context: context, baseSize: 25),
    ),
  );
}

void logOutMethod({
  required bool ismounted,
  required BuildContext context,
}) async {
  await CommonDbFunctions.setUserAuthStatus(isSignedIn: false);
  if (ismounted) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminLoginPage(),
      ),
      (route) => false,
    );
  }
}

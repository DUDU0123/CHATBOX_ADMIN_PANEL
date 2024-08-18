import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

Widget loginRequestTextWidget({
    required BuildContext context,
  }) {
    return TextWidgetCommon(
      text: 'Please Login to Admin Dashboard',
      fontWeight: FontWeight.w400,
      fontSize: responsiveFontSize(
        context: context,
        baseSize: 20,
      ),
      textColor: kWhite,
    );
  }

  Widget welcomeBackTextWidget({
    required BuildContext context,
  }) {
    return TextWidgetCommon(
      text: 'Welcome Back',
      fontWeight: FontWeight.bold,
      fontSize: responsiveFontSize(context: context, baseSize: 35),
      textColor: kWhite,
    );
  }
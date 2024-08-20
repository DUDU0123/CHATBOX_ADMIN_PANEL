import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

Widget commonAnimationWidget(
    {required BuildContext context,
    bool? isTextNeeded = true,
    String? text,
    double? fontSize,
    String? lottie}) {
  return Center(
    child: SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isTextNeeded != null)
            isTextNeeded
                ? TextWidgetCommon(
                    textAlign: TextAlign.center,
                    text: text ?? "Creating Otp...",
                    textColor: kLightGreenColor.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: responsiveFontSize(context: context, baseSize: fontSize??26),
                  )
                : zeroMeasuredWidget,
          Lottie.network(
            lottie ??
                'https://lottie.host/8d23344c-f904-4f4d-b66c-9193441547b9/1PlShH1AmG.json',
          ),
        ],
      ),
    ),
  );
}
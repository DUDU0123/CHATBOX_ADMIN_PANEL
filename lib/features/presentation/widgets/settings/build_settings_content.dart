import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/add_admin_dialogbox_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/admins_stream_listview.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/current_admin_data_show_widget.dart';

Widget buildSettingsContent({
  required BuildContext context,
  required bool ismounted,
}) {
  return Container(
    width: screenWidth(context: context),
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    decoration: containerBoxDecoration(),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        screenWidth(context: context) > 700
            ? Expanded(
                flex: 1,
                child: currentAdminDataShowWidget(
                  ismounted: ismounted,
                ),
              )
            : zeroMeasuredWidget,
        Expanded(
          child: Container(
            width: screenWidth(context: context),
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: containerBoxDecoration(),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidgetCommon(
                        text: "Other admins",
                        fontSize: responsiveFontSize(
                          context: context,
                          baseSize: 20,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                      GestureDetector(
                        onTap: () {
                          addAdminDialogBoxWidget(
                            context: context,
                          );
                        },
                        child: const Icon(
                          Icons.add_circle_outline,
                          color: kWhite,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: adminsStreamListview(),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
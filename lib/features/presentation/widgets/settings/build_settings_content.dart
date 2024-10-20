import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/app_navigation_widgets/navigation_widgets.dart';
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
        Expanded(
          flex: 1,
          child: currentAdminDataShowWidget(
            ismounted: ismounted,
          ),
        ),
      ],
    ),
  );
}

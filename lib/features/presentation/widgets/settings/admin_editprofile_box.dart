import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/admin_edit_profile_box_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/settings_small_widgets.dart';

ElevatedButton editProfileButton({
  required bool ismounted,
  required BuildContext context,
  required AdminModel? currentModel,
}) {
  return ElevatedButton.icon(
    onPressed: () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return LayoutBuilder(
            builder: (context, constraints) {
              // Calculate dialog width based on screen width
              final dialogWidth = constraints.maxWidth < 900
                  ? 0.9 * constraints.maxWidth
                  : 0.4 * constraints.maxWidth;
              // In your builder method
              return Center(
                child: SizedBox(
                  width: dialogWidth,
                  child: AdminEditProfileBox(
                    dialogWidth: dialogWidth,
                    currentModel: currentModel,
                  ),
                ),
              );
            },
          );
        },
      );
    },
    style: buttonStyle(),
    icon: const Icon(
      Icons.edit,
      color: kBlack,
      size: 20,
    ),
    label: TextWidgetCommon(
      text: 'Edit Profile',
      fontWeight: FontWeight.bold,
      textColor: kBlack,
      fontSize: responsiveFontSize(context: context, baseSize: 15),
    ),
  );
}

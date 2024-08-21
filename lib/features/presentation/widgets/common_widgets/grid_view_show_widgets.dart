import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/profile_image_show_circular_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/user_tile_row_widget.dart';

Widget gridViewShowWidget({
  required String no,
  required String userName,
  required String userPhoneNumber,
  required String userJoinedDate,
  required String? userProfileImage,
  required bool isTitle,
  required bool isSmallScreen,
  required BuildContext context,
  required bool isDisabledUserList,
  required bool isReportedUsersList,
  required UserModel? user,
  required bool isAppUsersList,
}) {
  return Container(
    width: isSmallScreen ? 150 : 200, // Provide width constraint
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min, // Take up minimum vertical space
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        profileImageShowCircularWidget(
          containerSize: 60,
          context: context,
          userProfileImage: userProfileImage,
        ),
        const SizedBox(height: 10),
        commonText(
          userPhoneNumber: userName,
          context: context,
          isSmallScreen: isSmallScreen,
          isTitle: isTitle,
        ),
        commonText(
          userPhoneNumber: userPhoneNumber,
          context: context,
          isSmallScreen: isSmallScreen,
          isTitle: isTitle,
        ),
        commonText(
          userPhoneNumber: userJoinedDate,
          context: context,
          isSmallScreen: isSmallScreen,
          isTitle: isTitle,
        ),
        if (!isTitle && (isDisabledUserList || isReportedUsersList))
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (user != null) {
                  if (isDisabledUserList) {
                    if (user.id != null) {
                      context
                          .read<UserBloc>()
                          .add(EnableUserEvent(userId: user.id!));
                    }
                  } else {
                    if (user.id != null) {
                      context
                          .read<UserBloc>()
                          .add(DisableUserEvent(userId: user.id!));
                    }
                  }
                }
              },
              child: Chip(
                label: TextWidgetCommon(
                  text: isDisabledUserList ? "Enable" : "Disable",
                  fontSize: responsiveFontSize(context: context, baseSize: 13),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

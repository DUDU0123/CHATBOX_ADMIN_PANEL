import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/profile_image_show_circular_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

Widget tileRowWidget({
  required String no,
  required String userName,
  required String userPhoneNumber,
  required String? userProfileImage,
  required String userJoinedDate,
  required UserModel? user,
  required bool isTitle,
  required bool isSmallScreen,
  required BuildContext context,
  required bool isDisabledUserList,
  required bool isReportedUserList,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      profileImageShowCircularWidget(
        containerSize: 60,
        context: context,
        userProfileImage: userProfileImage,
      ),
      flexResponsiveTextWidget(
        userPhoneNumber: userName,
        context: context,
        isSmallScreen: isSmallScreen,
        isTitle: isTitle,
      ),
      flexResponsiveTextWidget(
        userPhoneNumber: userPhoneNumber,
        context: context,
        isSmallScreen: isSmallScreen,
        isTitle: isTitle,
      ),
      flexResponsiveTextWidget(
        userPhoneNumber: userJoinedDate,
        context: context,
        isSmallScreen: isSmallScreen,
        isTitle: isTitle,
      ),
      if (!isTitle)
        Expanded(
          flex: 1,
          child: Row(
            children: [
              isDisabledUserList || isReportedUserList
                  ? GestureDetector(
                      onTap: () {
                        if (user != null) {
                          if (isDisabledUserList) {
                            if (user.id != null) {
                              context
                                  .read<AdminBloc>()
                                  .add(EnableUserEvent(userId: user.id!));
                            }
                          } else {
                            if (user.id != null) {
                              context
                                  .read<AdminBloc>()
                                  .add(DisableUserEvent(userId: user.id!));
                            }
                          }
                        }
                      },
                      child: Chip(
                        label: TextWidgetCommon(
                          text: isDisabledUserList ? "Enable" : "Disable",
                          fontSize: responsiveFontSize(
                              context: context, baseSize: 13),
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.disabled_visible_sharp),
                    ),
              !isDisabledUserList && !isReportedUserList
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline_outlined),
                    )
                  : zeroMeasuredWidget,
            ],
          ),
        ),
      if (isTitle)
        Expanded(
          flex: 1,
          child: TextWidgetCommon(
            text: "Actions",
            textColor: kWhite,
            fontSize: responsiveFontSize(
                context: context, baseSize: isSmallScreen ? 16 : 20),
            fontWeight: FontWeight.bold,
          ),
        ),
    ],
  );
}
Widget flexResponsiveTextWidget({
  required String userPhoneNumber,
  required BuildContext context,
  required bool isSmallScreen,
  required bool isTitle,
}) {
  return Expanded(
    flex: 2,
    child: TextWidgetCommon(
      textAlign: TextAlign.center,
      text: userPhoneNumber,
      textColor: kWhite,
      fontSize: responsiveFontSize(
          context: context, baseSize: isSmallScreen ? 16 : 20),
      fontWeight: isTitle ? FontWeight.bold : FontWeight.w400,
    ),
  );
}
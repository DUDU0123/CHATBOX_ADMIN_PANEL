  import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/app_navigation_widgets/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/user_tile_row_widget.dart';

Widget reportedUsersTableTitle({
    required BuildContext context,
    required bool isSmallScreen,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: containerBoxDecoration().copyWith(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: tileRowWidget(
        isAppUsersList: false,
        user: null,
        isReportedUserList: false,
        isDisabledUserList: true,
        userProfileImage: null,
        context: context,
        isTitle: true,
        no: 'No',
        userJoinedDate: 'Joined Date',
        userName: 'User',
        userPhoneNumber: 'Phone Number',
        isSmallScreen: isSmallScreen,
      ),
    );
  }


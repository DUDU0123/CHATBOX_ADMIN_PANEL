import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/user_tile_row_widget.dart';

Widget tileContainerWidget({
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
  required UserModel user,required bool isAppUsersList
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: containerBoxDecoration(),
    child: tileRowWidget(
      isAppUsersList: isAppUsersList,
      user: user,
      isReportedUserList: isReportedUsersList,
      userProfileImage: userProfileImage,
      isDisabledUserList: isDisabledUserList,
      context: context,
      isTitle: isTitle,
      no: no,
      userJoinedDate: userJoinedDate,
      userName: userName,
      userPhoneNumber: userPhoneNumber,
      isSmallScreen: isSmallScreen,
    ),
  );
}



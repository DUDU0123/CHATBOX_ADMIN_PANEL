import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/profile_image_show_circular_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/admin_editprofile_box.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/log_out_button.dart';

BlocBuilder<AdminBloc, AdminState> currentAdminDataShowWidget({
  required bool ismounted,
}) {
  return BlocBuilder<AdminBloc, AdminState>(
    builder: (context, state) {
      return ScrollConfiguration(
          behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileImageShowCircularWidget(
                defaultContainerColor: kWhite,
                userProfileImage: state.currentAdminData?.profilePhoto,
                context: context,
                borderRadius: 300,
                containerSize: 200,
                defaultContainerConstraint: 200,
              ),
              kHeight15,
              TextWidgetCommon(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                text: state.currentAdminData?.adminName ?? 'No admin',
                fontWeight: FontWeight.bold,
                textColor: kWhite,
                fontSize: responsiveFontSize(context: context, baseSize: 30),
              ),
              TextWidgetCommon(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                text: state.currentAdminData?.adminEmailAddress ?? 'No number',
                fontWeight: FontWeight.bold,
                textColor: kWhite,
                fontSize: responsiveFontSize(context: context, baseSize: 30),
              ),
              kHeight10,
              editProfileButton(
                currentModel: state.currentAdminData,
                ismounted: ismounted,
                context: context,
              ),
              kHeight15,
              logOutButton(
                ismounted: ismounted,
                context: context,
              ),
            ],
          ),
        ),
      );
    },
  );
}
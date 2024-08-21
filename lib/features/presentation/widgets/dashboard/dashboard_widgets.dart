import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/responsive_width_height.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

Widget dashboardWelcomNoteAndIcon({
  required BuildContext context,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: TextWidgetCommon(
          text: 'Welcome Back to Dashboard',
          fontWeight: FontWeight.bold,
          fontSize: responsiveFontSize(context: context, baseSize: 35),
          textColor: kWhite,
        ),
      ),
      BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          return CircleAvatar(
            radius: 20,
            backgroundColor: kWhite,
            child: state.currentAdminData != null
                ? state.currentAdminData!.profilePhoto != null
                    ? Image.network(state.currentAdminData!.profilePhoto!)
                    : const Icon(Icons.person, color: kLightGreenColor,)
                : const Icon(Icons.person, color: kGreenBlack,),
          );
        },
      )
    ],
  );
}

Widget dashBoardAppDetailGiveContainer({
  required BuildContext context,
  required String title,
  required String subTitle,
}) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: getResponsiveWidth(context, 10),
      vertical: getResponsiveHeight(context, 20),
    ),
    width: screenWidth(context: context) * 0.6,
    decoration: containerBoxDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidgetCommon(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: responsiveFontSize(
            context: context,
            baseSize: 20,
          ),
          textColor: kLightGreenColor,
        ),
        kHeight10,
        TextWidgetCommon(
          text: subTitle,
          fontWeight: FontWeight.bold,
          fontSize: responsiveFontSize(
            context: context,
            baseSize: 20,
          ),
          textColor: kWhite,
        ),
      ],
    ),
  );
}

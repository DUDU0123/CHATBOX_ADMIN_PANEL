import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/log_out_button.dart';

BlocBuilder<AdminBloc, AdminState> smallScreenAdminSettings({
  required bool mounted,
}) {
  return BlocBuilder<AdminBloc, AdminState>(
    builder: (context, state) {
      return PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () {
                logOutMethod(
                  ismounted: mounted,
                  context: context,
                );
              },
              child: TextWidgetCommon(
                text: "Logout",
                fontSize: responsiveFontSize(
                  context: context,
                  baseSize: 18,
                ),
              ),
            ),
          ];
        },
      );
    },
  );
}

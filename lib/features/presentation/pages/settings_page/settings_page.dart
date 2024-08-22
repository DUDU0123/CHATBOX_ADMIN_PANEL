import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/admin_edit_profile_box_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/build_settings_content.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/current_admin_data_show_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/log_out_button.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/small_screen_admin_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    context.read<AdminBloc>().add(GetAllAdminsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidgetCommon(
          text: 'Settings',
          fontWeight: FontWeight.bold,
          fontSize: responsiveFontSize(context: context, baseSize: 40),
          textColor: kWhite,
        ),
        actions: [
          screenWidth(context: context) < 700
              ? smallScreenAdminSettings(
                  mounted: mounted,
                )
              : zeroMeasuredWidget,
        ],
      ),
      backgroundColor: kAdminHomeScaffoldColor,
      body: buildSettingsContent(
        ismounted: mounted,
        context: context,
      ),
    );
  }
}

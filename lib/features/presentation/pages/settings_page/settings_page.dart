import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/build_settings_content.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminHomeScaffoldColor,
      body: buildSettingsContent(
        context: context,
        nameController: nameController,
        phoneNumberController: phoneNumberController,
      ),
    );
  }
}

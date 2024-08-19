import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/build_settings_content.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/settings_small_widgets.dart';

class AdminEditProfileBox extends StatefulWidget {
 const AdminEditProfileBox({
    super.key,required this.currentModel,
  });
    final AdminModel? currentModel;

  @override
  State<AdminEditProfileBox> createState() => _AdminEditProfileBoxState();
}

class _AdminEditProfileBoxState extends State<AdminEditProfileBox> {
  final TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    nameController.text  = widget.currentModel?.adminName??"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidgetCommon(
        text: "Edit Profile",
        fontWeight: FontWeight.bold,
        fontSize: responsiveFontSize(context: context, baseSize: 20),
        textColor: kWhite,
      ),
      actions: [
        responsiveTextField(
          context: context,
          hintText: 'Enter name',
          controller: nameController,
          keyboardType: TextInputType.name,
        ),
        responsiveButton(
          context: context,
          buttontext: "Save",
          buttonColor: kLightGreenColor,
          buttonFontSize: 16,
          buttonWidth: 100,
          onTap: () {},
        ),
      ],
    );
  }
}
ElevatedButton editProfileButton({
  required bool ismounted,
  required BuildContext context,
  required AdminModel? currentModel,
}) {
  return ElevatedButton.icon(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          return AdminEditProfileBox(currentModel: currentModel,);
        },
      );
    },
    style: buttonStyle(),
    icon: const Icon(
      Icons.power_settings_new_rounded,
      color: kBlack,
    ),
    label: TextWidgetCommon(
      text: 'Edit Profile',
      fontWeight: FontWeight.bold,
      textColor: kBlack,
      fontSize: responsiveFontSize(context: context, baseSize: 25),
    ),
  );
}
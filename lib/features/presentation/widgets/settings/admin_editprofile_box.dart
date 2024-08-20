import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/common_snackbar_widget.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/add_admin_dialogbox_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/settings_small_widgets.dart';

class AdminEditProfileBox extends StatefulWidget {
  const AdminEditProfileBox({
    super.key,
    required this.currentModel,
  });
  final AdminModel? currentModel;

  @override
  State<AdminEditProfileBox> createState() => _AdminEditProfileBoxState();
}

class _AdminEditProfileBoxState extends State<AdminEditProfileBox> {
  final TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.currentModel?.adminName ?? "";
    super.initState();
  }

  Uint8List? pickedFile;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: dialogHeadingText(
        context: context,
        text: "Edit Profile",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          pickedImageShowWIdget(),
          kHeight15,
          nameEnterField(
            dialogWidth: 300,
            nameController: nameController,
            context: context,
          ),
          kHeight10,
        ],
      ),
      actions: [
        responsiveButton(
          context: context,
          buttontext: "Save",
          buttonColor: kLightGreenColor,
          buttonFontSize: 16,
          buttonWidth: 100,
          onTap: () {
            if (widget.currentModel != null) {
              AdminModel updatedAdminModel = widget.currentModel!.copyWith(
                adminName: nameController.text,
              );
              context.read<AdminBloc>().add(
                    UpdateAdminEvent(
                      updatedAdminModel: updatedAdminModel,
                      imageFile: pickedFile,
                    ),
                  );
            }else{
              commonSnackBarWidget(context: context, contentText: "No admin to edit");
            }
            Navigator.pop(context);
          },
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
          return AdminEditProfileBox(
            currentModel: currentModel,
          );
        },
      );
    },
    style: buttonStyle(),
    icon: const Icon(
      Icons.edit,
      color: kBlack,size: 20,
    ),
    label: TextWidgetCommon(
      text: 'Edit Profile',
      fontWeight: FontWeight.bold,
      textColor: kBlack,
      fontSize: responsiveFontSize(context: context, baseSize: 15),
    ),
  );
}

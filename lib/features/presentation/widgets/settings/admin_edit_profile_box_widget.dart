import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/common_snackbar_widget.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/add_admin_dialogbox_widget.dart';
import 'package:provider/provider.dart';

class AdminEditProfileBox extends StatefulWidget {
  const AdminEditProfileBox({
    super.key,
    required this.currentModel,
    required this.dialogWidth,
  });
  final AdminModel? currentModel;
  final double dialogWidth;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dialogHeadingText(
                context: context,
                text: "Edit Profile",
              ),
              kHeight10,
              pickedImageShowWIdget(),
              kHeight15,
              valueEnterField(
                keyboardType: TextInputType.text,
                hintText: "Enter name",
                dialogWidth: widget.dialogWidth,
                controller: nameController,
                context: context,
              ),
              kHeight10,
              responsiveButton(
                context: context,
                buttontext: "Save",
                buttonColor: kLightGreenColor,
                buttonFontSize: 16,
                buttonWidth: 100,
                onTap: () {
                  editProfileData(
                    currentModel: widget.currentModel,
                    changedName: nameController.text,
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void editProfileData({
  required AdminModel? currentModel,
  required String changedName,
  required BuildContext context,
}) {
  if (currentModel != null) {
    AdminModel updatedAdminModel = currentModel.copyWith(
      adminName: changedName,
    );
    context.read<AdminBloc>().add(
          UpdateAdminEvent(
            updatedAdminModel: updatedAdminModel,
            imageFile:
                Provider.of<AdminBloc>(context, listen: false).state.pickedFile,
          ),
        );
  } else {
    commonSnackBarWidget(context: context, contentText: "No admin to edit");
  }
  Navigator.pop(context);
}

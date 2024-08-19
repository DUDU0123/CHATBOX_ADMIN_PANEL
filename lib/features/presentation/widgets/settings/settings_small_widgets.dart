import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';

Widget adminAddButton({
  required BuildContext context,
  required TextEditingController phoneNumberController,
  required TextEditingController nameController,
  required Uint8List? pickedFile,
}) {
  return responsiveButton(
    context: context,
    buttontext: 'Add',
    buttonColor: kLightGreenColor,
    buttonFontSize: 16,
    buttonWidth: 100,
    onTap: () {
      final adminBloc = context.read<AdminBloc>();
      final String? countryCode = adminBloc.state.country?.phoneCode;
      final mobileNumber = phoneNumberController.text.trim();
      final String phoneNumber = countryCode != null && countryCode.isNotEmpty
          ? "+$countryCode$mobileNumber"
          : "+91 $mobileNumber";
        final nameOfAdmin = nameController.text;
        log("Name of admin saved $nameOfAdmin");
      final AdminModel adminModel = AdminModel(
        adminAccountCreatedAt: DateTime.now().toString(),
        adminMobileNumber: phoneNumber,
        adminName: nameOfAdmin,
      );
      log("Name of admin ${nameController.text}");
      log("Number of admin ${phoneNumberController.text}");
      if (nameController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty) {
        context.read<AdminBloc>().add(
              AddAdminEvent(
                adminModel: adminModel,
                imageFile: pickedFile,
              ),
            );
      }
      Navigator.pop(context);
    },
  );
}

Widget pickedImageShowContainer({
  required AdminState state,
  required BuildContext context,
  bool isbuttonNeeded = true,
}) {
  return Container(
    height: 100,
    width: 100,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: MemoryImage(state.pickedFile!),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(
        1000,
      ),
      color: kBlack,
    ),
    child: isbuttonNeeded
        ? pickImageIconButton(
            context: context,
          )
        : zeroMeasuredWidget,
  );
}

Widget pickImageIconButton({
  required BuildContext context,
}) {
  return IconButton(
    onPressed: () async {
      context.read<AdminBloc>().add(ImagePickEvent());
    },
    icon: const Icon(
      Icons.camera,
      color: kLightGreenColor,
    ),
  );
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: kLightGreenColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

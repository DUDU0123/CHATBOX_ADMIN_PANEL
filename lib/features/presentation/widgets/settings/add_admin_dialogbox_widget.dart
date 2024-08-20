import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/settings_small_widgets.dart';

Future<dynamic> addAdminDialogBoxWidget({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController phoneNumberController,
  required Uint8List? pickedFile,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          // Calculate dialog width based on screen width
          final dialogWidth = constraints.maxWidth < 900
              ? 0.9 * constraints.maxWidth
              : 0.4 * constraints.maxWidth;
          // In your builder method
          return Center(
            child: SizedBox(
              width: dialogWidth,
              child: AlertDialog(
                title: dialogHeadingText(
                  context: context,
                  text: "Add admin",
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    pickedImageShowWIdget(),
                    kHeight15,
                    nameEnterField(
                      dialogWidth: dialogWidth,
                      nameController: nameController,
                      context: context,
                    ),
                    kHeight10,
                    SizedBox(
                      width: dialogWidth - 50,
                      child: responsiveTextField(
                        fontSize: 21,
                        context: context,
                        hintText: 'Enter phone number with country code',
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                actions: [
                  adminAddButton(
                    context: context,
                    phoneNumberController: phoneNumberController,
                    nameController: nameController,
                    pickedFile: pickedFile,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget nameEnterField({
  required double dialogWidth,
  required TextEditingController nameController,
  required BuildContext context,
}) {
  return SizedBox(
    width: dialogWidth - 50,
    child: responsiveField(
      fontSize: 21,
      controller: nameController,
      keyboardType: TextInputType.text,
      hintText: "Enter name",
      context: context,
    ),
  );
}

BlocBuilder<AdminBloc, AdminState> pickedImageShowWIdget() {
  return BlocBuilder<AdminBloc, AdminState>(
    builder: (context, state) {
      if (state.pickedFile != null) {
        return pickedImageShowContainer(
          isbuttonNeeded: true,
          context: context,
          state: state,
        );
      } else {
        return CircleAvatar(
          backgroundColor: kWhite,
          radius: 50,
          child: pickImageIconButton(
            context: context,
          ),
        );
      }
    },
  );
}

Widget dialogHeadingText({
  required BuildContext context,
  required String text,
}) {
  return TextWidgetCommon(
    text: text,
    fontSize: responsiveFontSize(
      context: context,
      baseSize: 20,
    ),
    fontWeight: FontWeight.bold,
  );
}

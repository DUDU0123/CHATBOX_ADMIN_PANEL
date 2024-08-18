import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/pick_file_from_storage.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/profile_image_show_circular_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

Widget buildSettingsContent({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController phoneNumberController,
}) {
  Uint8List? pickedFile;
  return Container(
    width: screenWidth(context: context),
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: kBlack,
      boxShadow: [
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: kBlack.withOpacity(0.4),
            offset: const Offset(1, 1)),
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: kWhite.withOpacity(0.4),
            offset: const Offset(1, 1))
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: responsiveWidth(context, screenWidth(context: context) / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kHeight15,
              profileImageShowCircularWidget(
                defaultContainerColor: kWhite,
                userProfileImage: null,
                context: context,
                borderRadius: 300,
                containerSize: 200,
                defaultContainerConstraint: 200,
              ),
              kHeight15,
              TextWidgetCommon(
                text: 'admin name',
                fontWeight: FontWeight.bold,
                textColor: kWhite,
                fontSize: responsiveFontSize(context: context, baseSize: 30),
              ),
              TextWidgetCommon(
                text: 'admin phone number',
                fontWeight: FontWeight.bold,
                textColor: kWhite,
                fontSize: responsiveFontSize(context: context, baseSize: 30),
              ),
              kHeight15,
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kLightGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(
                  Icons.power_settings_new_rounded,
                  color: kBlack,
                ),
                label: TextWidgetCommon(
                  text: 'Log Out',
                  fontWeight: FontWeight.bold,
                  textColor: kBlack,
                  fontSize: responsiveFontSize(context: context, baseSize: 25),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: screenWidth(context: context),
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kBlack,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: kBlack.withOpacity(0.4),
                    offset: const Offset(1, 1)),
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: kWhite.withOpacity(0.4),
                    offset: const Offset(1, 1))
              ],
            ),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidgetCommon(
                        text: "Other admins",
                        fontSize: responsiveFontSize(
                          context: context,
                          baseSize: 20,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    // Calculate dialog width based on screen width
                                    final dialogWidth =
                                        constraints.maxWidth < 900
                                            ? 0.9 * constraints.maxWidth
                                            : 0.4 * constraints.maxWidth;

                                    return Center(
                                      child: SizedBox(
                                        width: dialogWidth,
                                        child: AlertDialog(
                                          title: TextWidgetCommon(
                                            text: "Add admin",
                                            fontSize: responsiveFontSize(
                                              context: context,
                                              baseSize: 20,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundColor: kWhite,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      pickedFile =
                                                          await pickOneFile();
                                                    },
                                                    icon: Icon(
                                                      Icons.camera,
                                                      color: kBlack,
                                                    )),
                                              ),
                                              kHeight15,
                                              Center(
                                                child: SizedBox(
                                                  width: dialogWidth -
                                                      50, // To avoid content touching the edges
                                                  child: responsiveField(
                                                    fontSize: 21,
                                                    controller: nameController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    hintText: "Enter name",
                                                    context: context,
                                                  ),
                                                ),
                                              ),
                                              kHeight10,
                                              Center(
                                                child: SizedBox(
                                                  width: dialogWidth - 50,
                                                  child: responsiveTextField(
                                                    fontSize: 21,
                                                    context: context,
                                                    hintText:
                                                        'Enter phone number with country code',
                                                    controller:
                                                        phoneNumberController,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            responsiveButton(
                                              context: context,
                                              buttontext: 'Add',
                                              buttonColor: kLightGreenColor,
                                              buttonFontSize: 16,
                                              buttonWidth: 100,
                                              onTap: () {
                                                final adminBloc =
                                                    context.read<AdminBloc>();
                                                final String? countryCode =
                                                    adminBloc.state.country
                                                        ?.phoneCode;
                                                final mobileNumber =
                                                    phoneNumberController.text
                                                        .trim();
                                                final String phoneNumber =
                                                    countryCode != null &&
                                                            countryCode
                                                                .isNotEmpty
                                                        ? "+$countryCode$mobileNumber"
                                                        : "+91 $mobileNumber";
                                                final AdminModel adminModel =
                                                    AdminModel(
                                                  adminAccountCreatedAt:
                                                      DateTime.now().toString(),
                                                  adminMobileNumber:
                                                      phoneNumber,
                                                  adminName:
                                                      nameController.text,
                                                );
                                                context.read<AdminBloc>().add(
                                                      AddAdminEvent(
                                                        adminModel: adminModel,
                                                        imageFile: pickedFile,
                                                      ),
                                                    );
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.add_circle_outline,
                            color: kWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: kTransparent,
                            title: TextWidgetCommon(
                              text: "hello admin",
                              fontSize: responsiveFontSize(
                                context: context,
                                baseSize: 18,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => kHeight10,
                        itemCount: 10),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

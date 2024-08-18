import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/common_snackbar_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/main_navigate_page/main_navigation_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_login/admin_login_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/small_widgets.dart';

Widget adminLoginFormWidget({
  required BuildContext context,
  required TextEditingController phoneNumberController,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: BlocConsumer<AdminBloc, AdminState>(
            listener: (context, state) {
              if (state is AdminLoginSuccessState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainNavigationPage(),
                  ),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: screenHeight(context: context) * 0.2,
                    child: Center(
                      child: Image.asset(appLogo),
                    ),
                  ),
                  welcomeBackTextWidget(
                    context: context,
                  ),
                  kHeight15,
                  loginRequestTextWidget(
                    context: context,
                  ),
                  kHeight20,
                  responsiveTextField(
                    keyboardType: TextInputType.phone,
                    hintText: "Enter phone number",
                    controller: phoneNumberController,
                    context: context,
                  ),
                  kHeight30,
                  responsiveButton(
                    onTap: () {
                      final adminBloc = context.read<AdminBloc>();
                      final String? countryCode =
                          adminBloc.state.country?.phoneCode;
                      final mobileNumber = phoneNumberController.text.trim();
                      final String phoneNumber =
                          countryCode != null && countryCode.isNotEmpty
                              ? "+$countryCode$mobileNumber"
                              : "+91 $mobileNumber";
                      adminBloc.add(
                        AdminSignInEvent(
                          phoneNumber: phoneNumber,
                          context: context,
                        ),
                      );
                      log("Button Pressed login");
                    },
                    buttonWidth: 400,
                    buttonColor: kOrange,
                    buttonFontSize: 16,
                    buttontext: "Login",
                    context: context,
                  ),
                  // kHeight10,
                  // GestureDetector(
                  //   onTap: () {
                  //     AdminAuthMethods.forgotEmailDialogBox(
                  //       context: context,
                  //       forgotPasswordController: forgotPasswordController,
                  //     );
                  //   },
                  //   child: forgotPasswordTextWidget(
                  //     context: context,
                  //   ),
                  // ),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      )
    ],
  );
}

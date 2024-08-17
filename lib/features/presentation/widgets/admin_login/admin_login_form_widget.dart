import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/admin_auth_methods.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/main_navigate_page/main_navigation_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_login/admin_login_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';

Widget adminLoginFormWidget({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController forgotPasswordController,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
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
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter email",
                controller: emailController,
                context: context,
              ),
              kHeight10,
              responsiveTextField(
                keyboardType: TextInputType.visiblePassword,
                hintText: "Enter password",
                controller: passwordController,
                context: context,
              ),
              kHeight30,
              responsiveButton(
                onTap: () {
                  log("Button Pressed login");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavigationPage(),
                    ),
                    (route) => false,
                  );
                },
                buttonWidth: 400,
                buttonColor: kOrange,
                buttonFontSize: 16,
                buttontext: "Login",
                context: context,
              ),
              kHeight10,
              GestureDetector(
                onTap: () {
                  AdminAuthMethods.forgotEmailDialogBox(
                    context: context,
                    forgotPasswordController: forgotPasswordController,
                  );
                },
                child: forgotPasswordTextWidget(
                  context: context,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      )
    ],
  );
}

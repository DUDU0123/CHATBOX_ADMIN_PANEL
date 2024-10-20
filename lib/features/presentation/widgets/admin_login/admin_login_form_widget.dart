import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_login/admin_login_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';

Widget adminLoginFormWidget({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
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
              responsiveField(
                keyboardType: TextInputType.phone,
                hintText: "Enter email",
                controller: emailController,
                context: context,
                fontSize: 22,
              ),
              kHeight10,
              responsiveField(
                keyboardType: TextInputType.phone,
                hintText: "Enter password",
                controller: passwordController,
                context: context,
                fontSize: 22,
              ),
              kHeight30,
              responsiveButton(
                onTap: () {
                  final adminBloc = context.read<AdminBloc>();
                  adminBloc.add(
                    AdminSignInEvent(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context,
                    ),
                  );
                },
                buttonWidth: 400,
                buttonColor: kOrange,
                buttonFontSize: 16,
                buttontext: "Login",
                context: context,
              ),
              const Spacer(),
            ],
          ),
        ),
      )
    ],
  );
}

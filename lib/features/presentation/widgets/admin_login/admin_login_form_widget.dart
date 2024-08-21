import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_login/admin_login_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';

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
                keyboardType: TextInputType.phone,
                hintText: "Enter phone number",
                controller: phoneNumberController,
                context: context,
                fontSize: 22,
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

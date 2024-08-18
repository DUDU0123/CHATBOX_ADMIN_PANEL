import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_login/admin_login_form_widget.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenBlack,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: adminLoginFormWidget(
                  phoneNumberController: phoneNumberController,
                  context: context,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

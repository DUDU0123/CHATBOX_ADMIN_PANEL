import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_login/admin_login_form_widget.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController forgotPasswordController =
      TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    forgotPasswordController.dispose();
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
                  emailController: emailController,
                  forgotPasswordController: forgotPasswordController,
                  passwordController: passwordController,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/admin_login/admin_login_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/main_navigate_page/main_navigation_page.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  void initState() {
    context.read<AdminBloc>().add(CheckIfAdminSignedInEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<AdminBloc>().state.isAdminSignedIn != null) {
      if (context.watch<AdminBloc>().state.isAdminSignedIn!) {
        return const MainNavigationPage();
      } else {
        return const AdminLoginPage();
      }
    } else {
      return zeroMeasuredWidget;
    }
  }
}

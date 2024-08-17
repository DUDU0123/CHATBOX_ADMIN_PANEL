import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/admin_dashboard/admin_dashboard.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/app_users_list_page/app_users_list_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/disabled_users_page/disabled_users_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/reported_accounts_page/reported_accounts_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/settings_page/settings_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/admin_home_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/navigation_widgets.dart';

final pages = [
  const AdminDashboard(),
  const AppUsersListPage(),
  const DisabledUsersPage(),
  const ReportedAccountsPage(),
  const SettingsPage(),
];

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminHomeScaffoldColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            // For larger screens, show side navigation
            return Row(
              children: [
                buildSideNavigation(
                  context: context,
                ),
                Expanded(
                  child: buildMainContent(context: context),
                ),
              ],
            );
          } else {
            // For smaller screens, show content with bottom navigation
            return Column(
              children: [
                Expanded(
                  child: buildMainContent(context: context),
                ),
                buildBottomNavigation(
                  context: context,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

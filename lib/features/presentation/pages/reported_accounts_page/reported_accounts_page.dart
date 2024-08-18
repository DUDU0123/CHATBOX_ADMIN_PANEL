import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/reported_users/reported_users_stream_list_view.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/reported_users/reported_users_table_title.dart';
class ReportedAccountsPage extends StatefulWidget {
  const ReportedAccountsPage({super.key});

  @override
  State<ReportedAccountsPage> createState() => _ReportedAccountsPageState();
}

class _ReportedAccountsPageState extends State<ReportedAccountsPage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetAllReportedAccountsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextWidgetCommon(
                  text: 'Reported Users',
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 25 : 35,
                  textColor: kWhite,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: containerBoxDecoration().copyWith(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      reportedUsersTableTitle(
                        context: context,
                        isSmallScreen: isSmallScreen,
                      ),
                      Expanded(
                        child: reportedUsersStreamListview(
                          isSmallScreen: isSmallScreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


}

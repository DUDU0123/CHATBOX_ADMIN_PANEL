import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/responsive_width_height.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/dashboard/dashboard_widgets.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
     context.read<UserBloc>().add(GetAllUsersEvent());
      context.read<UserBloc>().add(GetAllReportedAccountsEvent());
    context.read<UserBloc>().add(GetAllDisabledUsersEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Define a breakpoint for small screens
    const double smallScreenBreakpoint = 600;

    return Scaffold(
      body: SizedBox(
        width: screenWidth(context: context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: dashboardWelcomNoteAndIcon(
                context: context,
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Determine the number of columns based on screen width
                  int crossAxisCount =
                      constraints.maxWidth > smallScreenBreakpoint ? 2 : 1;

                  // Adjust childAspectRatio based on the number of columns
                  double childAspectRatio = crossAxisCount == 2 ? 3 : 4;

                  return GridView.count(
                    padding: EdgeInsets.symmetric(
                        vertical: getResponsiveHeight(context, 10),
                        horizontal: getResponsiveWidth(context, 10)),
                    mainAxisSpacing: getResponsiveHeight(context, 30),
                    crossAxisSpacing: getResponsiveWidth(context, 10),
                    childAspectRatio: childAspectRatio,
                    crossAxisCount: crossAxisCount,
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          return StreamBuilder<List<UserModel>>(
                              stream: state.usersList,
                              builder: (context, snapshot) {
                                return dashBoardAppDetailGiveContainer(
                                  subTitle: snapshot.data != null
                                      ? snapshot.data!.length.toString()
                                      : '0',
                                  title: 'No. of App Users',
                                  context: context,
                                );
                              });
                        },
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          return StreamBuilder<List<UserModel>>(
                              stream: state.reportedAccounts,
                              builder: (context, snapshot) {
                                final reportedUsers = snapshot.data
                                    ?.where((s) => s.isDisabled == false);
                                return dashBoardAppDetailGiveContainer(
                                  subTitle: reportedUsers != null
                                      ? reportedUsers.length.toString()
                                      : '0',
                                  title: 'No. of Reported users',
                                  context: context,
                                );
                              });
                        },
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          return StreamBuilder<List<UserModel>>(
                              stream: state.disabledUsersList,
                              builder: (context, snapshot) {
                                return dashBoardAppDetailGiveContainer(
                                  subTitle: snapshot.data != null
                                      ? snapshot.data!.length.toString()
                                      : '0',
                                  title: 'No. of Disabled users',
                                  context: context,
                                );
                              });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

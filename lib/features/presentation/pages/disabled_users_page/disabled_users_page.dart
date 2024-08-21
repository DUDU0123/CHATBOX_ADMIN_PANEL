import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/app_navigation_widgets/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/disabled_users/disabled_users_stream_listview.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/disabled_users/disabled_users_table_title.dart';
class DisabledUsersPage extends StatefulWidget {
  const DisabledUsersPage({super.key});

  @override
  State<DisabledUsersPage> createState() => _DisabledUsersPageState();
}

class _DisabledUsersPageState extends State<DisabledUsersPage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetAllDisabledUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          final isMidOverScreen = constraints.maxWidth < 845;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextWidgetCommon(
                  text: 'Disabled Users',
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
                      if(!isMidOverScreen)
                      disabledUserstableTitle(
                        context: context,
                        isSmallScreen: isSmallScreen,
                      ),
                      Expanded(
                        child: disabledUsersStreamListView(
                          isMidOverScreen: isMidOverScreen,
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

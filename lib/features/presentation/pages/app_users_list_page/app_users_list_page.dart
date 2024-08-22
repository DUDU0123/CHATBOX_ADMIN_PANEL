import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/app_navigation_widgets/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/app_users/app_users_stream_listview.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/app_users/app_users_table_title.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

class AppUsersListPage extends StatefulWidget {
  const AppUsersListPage({super.key});

  @override
  State<AppUsersListPage> createState() => _AppUsersListPageState();
}

class _AppUsersListPageState extends State<AppUsersListPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<UserBloc>().add(GetAllUsersEvent());
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidgetCommon(
                      text: 'App Users',
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 25 : 35,
                      textColor: kWhite,
                    ),
                    SizedBox(
                      width: responsiveWidth(context, 180),
                      child: responsiveField(
                        onChanged: (value) async {
                          String searchInput = value.trim();
                          if (searchInput.isNotEmpty) {
                            context.read<UserBloc>().add(
                                SearchUsersEvent(searchInput: value.trim()));
                          } else {
                            context.read<UserBloc>().add(GetAllUsersEvent());
                          }
                        },
                        textColor: kWhite,
                        borderColor: kWhite,
                        containerColor: kWhite.withOpacity(0.1),
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        hintText: "Search user...",
                        context: context,
                        fontSize: 18,
                      ),
                    ),
                  ],
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
                      if (!isMidOverScreen)
                        appUsersTableTitle(
                          context: context,
                          isSmallScreen: isSmallScreen,
                        ),
                      Expanded(
                        child: appUsersStreamListview(
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

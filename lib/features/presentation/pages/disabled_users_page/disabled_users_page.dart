import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/date_time_provider.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/app_users_list_page/app_users_list_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/small_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: containerBoxDecoration().copyWith(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: tileRowWidget(
                          isDisabledUserList: true,
                          userProfileImage: null,
                          context: context,
                          isTitle: true,
                          no: 'No',
                          userJoinedDate: 'Joined Date',
                          userName: 'User',
                          userPhoneNumber: 'Phone Number',
                          isSmallScreen: isSmallScreen,
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            return StreamBuilder<List<UserModel>>(
                              stream: state.disabledUsersList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return emptyShowWidget(
                                      context: context,
                                      text: "No disabled users in database");
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return emptyShowWidget(
                                      context: context,
                                      text: "No disabled users in database");
                                }
                                
                                final List<UserModel> disabledUsers =
                                    snapshot.data!;
                                    log(disabledUsers.toString());
                                return ListView.separated(
                                  padding: const EdgeInsets.all(10),
                                  itemBuilder: (context, index) {
                                    log(disabledUsers[index]
                                        .userProfileImage
                                        .toString());
                                    return tileContainerWidget(
                                      isDisabledUserList: true,
                                      userProfileImage:
                                          disabledUsers[index].userProfileImage,
                                      isTitle: false,
                                      context: context,
                                      no: (index + 1).toString(),
                                      userName: disabledUsers[index].userName ?? '',
                                      userJoinedDate:
                                          DateProvider.convertDateToFormatted(
                                              date:
                                                  disabledUsers[index].createdAt ??
                                                      ''),
                                      userPhoneNumber:
                                          disabledUsers[index].phoneNumber ?? '',
                                      isSmallScreen: isSmallScreen,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      kHeight10,
                                  itemCount: disabledUsers.length,
                                );
                              },
                            );
                          },
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

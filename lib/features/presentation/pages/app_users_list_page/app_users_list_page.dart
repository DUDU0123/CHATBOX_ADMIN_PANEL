import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/date_time_provider.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/small_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

class AppUsersListPage extends StatefulWidget {
  const AppUsersListPage({super.key});

  @override
  State<AppUsersListPage> createState() => _AppUsersListPageState();
}

class _AppUsersListPageState extends State<AppUsersListPage> {
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

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextWidgetCommon(
                  text: 'App Users',
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
                          isDisabledUserList: false,
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
                              stream: state.usersList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return emptyShowWidget(
                                      context: context,
                                      text: "No users in database");
                                }
                                final List<UserModel> usersList =
                                    snapshot.data!;
                                return ListView.separated(
                                  padding: const EdgeInsets.all(10),
                                  itemBuilder: (context, index) {
                                    log(usersList[index]
                                        .userProfileImage
                                        .toString());
                                    return tileContainerWidget(
                                      isDisabledUserList: false,
                                      userProfileImage:
                                          usersList[index].userProfileImage,
                                      isTitle: false,
                                      context: context,
                                      no: (index + 1).toString(),
                                      userName: usersList[index].userName ?? '',
                                      userJoinedDate:
                                          DateProvider.convertDateToFormatted(
                                              date:
                                                  usersList[index].createdAt ??
                                                      ''),
                                      userPhoneNumber:
                                          usersList[index].phoneNumber ?? '',
                                      isSmallScreen: isSmallScreen,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      kHeight10,
                                  itemCount: usersList.length,
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

Widget tileContainerWidget({
  required String no,
  required String userName,
  required String userPhoneNumber,
  required String userJoinedDate,
  required String? userProfileImage,
  required bool isTitle,
  required bool isSmallScreen,
  required BuildContext context,
  required bool isDisabledUserList,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: containerBoxDecoration(),
    child: tileRowWidget(
      userProfileImage: userProfileImage,
      isDisabledUserList: isDisabledUserList,
      context: context,
      isTitle: isTitle,
      no: no,
      userJoinedDate: userJoinedDate,
      userName: userName,
      userPhoneNumber: userPhoneNumber,
      isSmallScreen: isSmallScreen,
    ),
  );
}

Widget tileRowWidget({
  required String no,
  required String userName,
  required String userPhoneNumber,
  required String? userProfileImage,
  required String userJoinedDate,
  required bool isTitle,
  required bool isSmallScreen,
  required BuildContext context,
  required bool isDisabledUserList,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      userProfileImage != null && userProfileImage.isNotEmpty
          ? Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: kBlack, borderRadius: BorderRadius.circular(150)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.network(
                  fit: BoxFit.cover,
                  userProfileImage,
                  errorBuilder: (context, error, stackTrace) {
                    log(error.toString());
                    return commonProfileDefaultIconCircularCotainer(
                      context: context,
                      containerConstraint: 56,
                    );
                  },
                ),
              ),
            )
          : commonProfileDefaultIconCircularCotainer(
              context: context,
              containerConstraint: 56,
            ),
      flexResponsiveTextWidget(
        userPhoneNumber: userName,
        context: context,
        isSmallScreen: isSmallScreen,
        isTitle: isTitle,
      ),
      flexResponsiveTextWidget(
        userPhoneNumber: userPhoneNumber,
        context: context,
        isSmallScreen: isSmallScreen,
        isTitle: isTitle,
      ),
      flexResponsiveTextWidget(
        userPhoneNumber: userJoinedDate,
        context: context,
        isSmallScreen: isSmallScreen,
        isTitle: isTitle,
      ),
      if (!isTitle)
        Expanded(
          flex: 1,
          child: Row(
            children: [
              isDisabledUserList
                  ? Chip(
                      label: TextWidgetCommon(
                        text: "Enable",
                        fontSize:
                            responsiveFontSize(context: context, baseSize: 13),
                      ),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.disabled_visible_sharp),
                    ),
             !isDisabledUserList? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline_outlined),
              ):zeroMeasuredWidget,
            ],
          ),
        ),
      if (isTitle)
         Expanded(
          flex: 1,
          child: TextWidgetCommon(
            text: "Actions",
            textColor: kWhite,
            fontSize:responsiveFontSize(
          context: context, baseSize: isSmallScreen ? 16 : 20),
            fontWeight: FontWeight.bold,
          ),
        ),
    ],
  );
}

Widget flexResponsiveTextWidget({
  required String userPhoneNumber,
  required BuildContext context,
  required bool isSmallScreen,
  required bool isTitle,
}) {
  return Expanded(
    flex: 2,
    child: TextWidgetCommon(
      textAlign: TextAlign.center,
      text: userPhoneNumber,
      textColor: kWhite,
      fontSize: responsiveFontSize(
          context: context, baseSize: isSmallScreen ? 16 : 20),
      fontWeight: isTitle ? FontWeight.bold : FontWeight.w400,
    ),
  );
}

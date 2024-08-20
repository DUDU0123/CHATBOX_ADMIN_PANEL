import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/date_time_provider.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/small_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/tile_container_widget.dart';

BlocBuilder<UserBloc, UserState> reportedUsersStreamListview({
    required bool isSmallScreen,
  }) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return StreamBuilder<List<UserModel>>(
          stream: state.reportedAccounts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return emptyShowWidget(
                context: context,
                text: "No reported accounts in database",
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return emptyShowWidget(
                context: context,
                text: "No reported accounts in database",
              );
            }
            final List<UserModel> reportedUsers = snapshot.data!.where((user)=>!user.isDisabled!).toList();
            if (reportedUsers.isEmpty) {
              return emptyShowWidget(
                context: context,
                text: "No reported accounts in database",
              );
            }
            log(reportedUsers.toString());
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  log(reportedUsers[index].userProfileImage.toString());
                  return tileContainerWidget(
                    isAppUsersList: false,
                    user: reportedUsers[index],
                    isReportedUsersList: true,
                    isDisabledUserList: false,
                    userProfileImage: reportedUsers[index].userProfileImage,
                    isTitle: false,
                    context: context,
                    no: (index + 1).toString(),
                    userName: reportedUsers[index].userName ?? '',
                    userJoinedDate: DateProvider.convertDateToFormatted(
                        date: reportedUsers[index].createdAt ?? ''),
                    userPhoneNumber: reportedUsers[index].phoneNumber ?? '',
                    isSmallScreen: isSmallScreen,
                  );
                },
                separatorBuilder: (context, index) => kHeight10,
                itemCount: reportedUsers.length,
              ),
            );
          },
        );
      },
    );
  }
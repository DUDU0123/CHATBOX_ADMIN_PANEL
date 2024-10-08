import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/core/utils/date_time_provider.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/grid_view_show_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/small_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/tile_container_widget.dart';

BlocBuilder<UserBloc, UserState> disabledUsersStreamListView({
  required bool isSmallScreen,
  required bool isMidOverScreen,
}) {
  return BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      return StreamBuilder<List<UserModel>>(
        stream: state.disabledUsersList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return emptyShowWidget(
                context: context,
                text: "No disabled users in database ${snapshot.error}");
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return emptyShowWidget(
                context: context, text: "No disabled users in database");
          }

          final List<UserModel> disabledUsers = snapshot.data!;
          return ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: !isMidOverScreen
                ? ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return tileContainerWidget(
                        isAppUsersList: false,
                        user: disabledUsers[index],
                        isReportedUsersList: false,
                        isDisabledUserList: true,
                        userProfileImage: disabledUsers[index].userProfileImage,
                        isTitle: false,
                        context: context,
                        no: (index + 1).toString(),
                        userName: disabledUsers[index].userName ?? '',
                        userJoinedDate: DateProvider.convertDateToFormatted(
                            date: disabledUsers[index].createdAt ?? ''),
                        userPhoneNumber: disabledUsers[index].phoneNumber ?? '',
                        isSmallScreen: isSmallScreen,
                      );
                    },
                    separatorBuilder: (context, index) => kHeight10,
                    itemCount: disabledUsers.length,
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    itemCount: disabledUsers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        // childAspectRatio: null,
                        crossAxisCount: isSmallScreen ? 2 : 3),
                    itemBuilder: (context, index) {
                      return gridViewShowWidget(
                        isAppUsersList: false,
                        user: disabledUsers[index],
                        isReportedUsersList: false,
                        isDisabledUserList: true,
                        userProfileImage: disabledUsers[index].userProfileImage,
                        isTitle: false,
                        context: context,
                        no: (index + 1).toString(),
                        userName: disabledUsers[index].userName ?? '',
                        userJoinedDate: DateProvider.convertDateToFormatted(
                            date: disabledUsers[index].createdAt ?? ''),
                        userPhoneNumber: disabledUsers[index].phoneNumber ?? '',
                        isSmallScreen: isSmallScreen,
                      );
                    },
                  ),
          );
        },
      );
    },
  );
}

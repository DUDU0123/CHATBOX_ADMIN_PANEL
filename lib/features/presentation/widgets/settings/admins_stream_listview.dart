import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/config/all_bloc_provider.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/small_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

BlocBuilder<AdminBloc, AdminState> adminsStreamListview() {
  return BlocBuilder<AdminBloc, AdminState>(
    builder: (context, state) {
      return StreamBuilder<List<AdminModel>>(
          stream: state.adminsList,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return emptyShowWidget(context: context, text: "No admins found");
            }
            final List<AdminModel>? adminList = snapshot.data
                ?.where((admin) => admin.id != state.currentAdminData?.id)
                .toList();
            if (adminList == null) {
              return emptyShowWidget(context: context, text: "No admins found");
            }
            if (adminList.isEmpty) {
              return emptyShowWidget(context: context, text: "No admins found");
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: kTransparent,
                  leading: adminList[index].profilePhoto != null
                      ? imageContainer(
                          image: adminList[index].profilePhoto!,
                        )
                      : defaultContainerIcon(),
                  title: TextWidgetCommon(
                    text: adminList[index].adminName ?? '',
                    fontSize: responsiveFontSize(
                      context: context,
                      baseSize: 18,
                    ),
                  ),
                  trailing: IconButton(onPressed: () {
                    // remove an admin from list
                    final adminId = adminList[index].id;
                   
                  }, icon: const Icon(Icons.remove_circle_outline, color: kWhite,)),
                );
              },
              separatorBuilder: (context, index) => kHeight10,
              itemCount: adminList.length,
            );
          });
    },
  );
}

Widget defaultContainerIcon({
  double? containerSize,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        1000,
      ),
      color: kWhite,
    ),
    alignment: Alignment.center,
    height: containerSize ?? 50,
    width: containerSize ?? 50,
    child: const Icon(
      Icons.person,
      color: kBlack,
    ),
  );
}

Widget imageContainer({
  required String image,
}) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        1000,
      ),
      color: kWhite,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => defaultContainerIcon(),
      ),
    ),
  );
}

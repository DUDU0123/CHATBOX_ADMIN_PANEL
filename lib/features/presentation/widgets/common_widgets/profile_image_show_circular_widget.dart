import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/small_widgets.dart';

Widget profileImageShowCircularWidget({
  required String? userProfileImage,
  double? containerSize,
  double? borderRadius,
  double? defaultContainerConstraint,
  required BuildContext context, Color? defaultContainerColor,
}) {
  return userProfileImage != null && userProfileImage.isNotEmpty
      ? Container(
          height: containerSize ?? 50,
          width: containerSize ?? 50,
          decoration: BoxDecoration(
              color: kBlack,
              borderRadius: BorderRadius.circular(borderRadius ?? 150)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 150),
            child: Image.network(
              fit: BoxFit.cover,
              userProfileImage,
              errorBuilder: (context, error, stackTrace) {
                log(error.toString());
                return commonProfileDefaultIconCircularCotainer(
                  defaultContainerColor: defaultContainerColor,
                  context: context,
                  containerConstraint:  defaultContainerConstraint??56,
                );
              },
            ),
          ),
        )
      : commonProfileDefaultIconCircularCotainer(
        defaultContainerColor: defaultContainerColor,
          context: context,
          containerConstraint: defaultContainerConstraint??56,
        );
}


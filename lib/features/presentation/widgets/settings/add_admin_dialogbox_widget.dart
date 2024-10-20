import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/settings_small_widgets.dart';

Widget valueEnterField({
  required double dialogWidth,required String hintText,
  required TextEditingController controller,required TextInputType? keyboardType,
  required BuildContext context,
}) {
  return SizedBox(
    width: dialogWidth - 50,
    child: responsiveField(
      fontSize: 21,
      controller: controller,
      keyboardType: keyboardType,
      hintText: hintText,
      context: context,
    ),
  );
}

BlocBuilder<AdminBloc, AdminState> pickedImageShowWIdget() {
  return BlocBuilder<AdminBloc, AdminState>(
    builder: (context, state) {
      if (state.pickedFile != null) {
        return pickedImageShowContainer(
          isbuttonNeeded: true,
          context: context,
          state: state,
        );
      } else {
        return CircleAvatar(
          backgroundColor: kWhite,
          radius: 50,
          child: pickImageIconButton(
            context: context,
          ),
        );
      }
    },
  );
}

Widget dialogHeadingText({
  required BuildContext context,
  required String text,
}) {
  return TextWidgetCommon(
    text: text,
    fontSize: responsiveFontSize(
      context: context,
      baseSize: 20,
    ),
    fontWeight: FontWeight.bold,
  );
}

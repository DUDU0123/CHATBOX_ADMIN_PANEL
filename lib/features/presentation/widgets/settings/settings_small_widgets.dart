import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:provider/provider.dart';

Widget pickedImageShowContainer({
  required AdminState state,
  required BuildContext context,
  bool isbuttonNeeded = true,
}) {
  return Container(
    height: 100,
    width: 100,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: MemoryImage(state.pickedFile!),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(
        1000,
      ),
      color: kBlack,
    ),
    child: isbuttonNeeded
        ? pickImageIconButton(
            context: context,
          )
        : zeroMeasuredWidget,
  );
}

Widget pickImageIconButton({
  required BuildContext context,
}) {
  return IconButton(
    onPressed: () async {
      context.read<AdminBloc>().add(ImagePickEvent());
    },
    icon: const Icon(
      Icons.camera,
      color: kLightGreenColor,
    ),
  );
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: kLightGreenColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

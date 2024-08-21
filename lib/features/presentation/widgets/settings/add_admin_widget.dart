import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/add_admin_dialogbox_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/settings/settings_small_widgets.dart';

class AddAdminWidget extends StatefulWidget {
   const AddAdminWidget({
    super.key,
    required this.dialogWidth,
  });

  final double dialogWidth;

  @override
  State<AddAdminWidget> createState() => _AddAdminWidgetState();
}

class _AddAdminWidgetState extends State<AddAdminWidget> {
     TextEditingController nameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ScrollConfiguration(
        behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dialogHeadingText(
                  context: context,
                  text: "Add Admin",
                ),
                kHeight10,
                pickedImageShowWIdget(),
                kHeight15,
                nameEnterField(
                  dialogWidth: widget.dialogWidth,
                  nameController: nameController,
                  context: context,
                ),
                kHeight10,
                SizedBox(
                  width: widget.dialogWidth - 50,
                  child: responsiveTextField(
                    fontSize: 21,
                    context: context,
                    hintText: 'Enter phone number',
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                kHeight10,
                adminAddButton(
                context: context,
                phoneNumberController: phoneNumberController,
                nameController: nameController,
              ),
              ],
            ),
        ),
      ),
    );
  }
}

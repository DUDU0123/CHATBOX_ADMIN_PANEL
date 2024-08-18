import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/admin/admin_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';

Widget emptyShowWidget({required BuildContext context, required String text}) {
  return SizedBox(
    width: screenWidth(context: context),
    height: screenHeight(context: context),
    child: Center(
      child: SizedBox(
        width: 250,
        child: TextWidgetCommon(
          textAlign: TextAlign.center,
          text: text,
          textColor: kWhite,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ),
  );
}

Widget commonProfileDefaultIconCircularCotainer(
    {required BuildContext context, double? containerConstraint, Color? defaultContainerColor,}) {
  return Container(
    decoration:BoxDecoration(
      color: defaultContainerColor?? kBlack,
      shape: BoxShape.circle,
    ),
    width: containerConstraint ?? 50,
    height: containerConstraint?? 50,
    child:  Center(
      child: Icon(
        Icons.account_circle,color: defaultContainerColor==kWhite?kBlack:kWhite,size: containerConstraint,
      ),
    ),
  );
}

Widget countrySelectedShowWidget() {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        return state.country != null
            ? TextWidgetCommon(
                text: (state.country!.flagEmoji + state.country!.phoneCode),
                fontWeight: FontWeight.w500,
                fontSize: 20,
                textColor: kBlack,
              )
            : Row(
                children: [
                  Image.asset(
                    indiaFlag,
                    scale: 18,
                  ),
                  kWidth5,
                 const TextWidgetCommon(
                    text: "91",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    textColor: kBlack,
                  )
                ],
              );
      },
    ),
  );
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/main_navigate_page/main_navigation_page.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';

BottomNavigationBarItem buildBottomNavItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  Widget buildNavButton({
    required BuildContext context,
    required IconData icon,
    required String text,
    bool isSelected = false,
    void Function()? onTap,
  }) {
    return responsiveButton(
      leadingWidget: Icon(
        icon,
        color: isSelected ? kLightGreenColor : kNotSelectedColor,
      ),
      height: 60,
      context: context,
      buttontext: text,
      buttonColor: isSelected ? kButtonBlackColor : kTransparent,
      buttonFontSize: 20,
      buttonWidth: 200,
      textColor: isSelected ? kLightGreenColor : kNotSelectedColor,
      onTap: onTap,
    );
  }

  Widget buildMainContent({
    required BuildContext context,
  }) {
    return pages[context.watch<NavigationBloc>().state.currentIndex ?? 0];
  }
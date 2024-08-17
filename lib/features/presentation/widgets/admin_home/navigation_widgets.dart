import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/admin_home_widgets.dart';

Widget buildSideNavigation({
  required BuildContext context,
}) {
  final currentIndex = context.watch<NavigationBloc>().state.currentIndex ?? 0;
  return Container(
    width: 230,
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    decoration: containerBoxDecoration(),
    child: Column(
      children: [
        buildNavButton(
          onTap: () {
            context
                .read<NavigationBloc>()
                .add(const NavigateToPageEvent(currentIndex: 0));
          },
          context: context,
          icon: Icons.dashboard_rounded,
          text: "Dashboard",
          isSelected: currentIndex == 0 ? true : false,
        ),
        kHeight15,
        buildNavButton(
          onTap: () {
            context
                .read<NavigationBloc>()
                .add(const NavigateToPageEvent(currentIndex: 1));
          },
          context: context,
          icon: Icons.group,
          text: "App Users",
          isSelected: currentIndex == 1 ? true : false,
        ),
        kHeight15,
        buildNavButton(
          onTap: () {
            context
                .read<NavigationBloc>()
                .add(const NavigateToPageEvent(currentIndex: 2));
          },
          context: context,
          icon: Icons.report_gmailerrorred_outlined,
          text: "Reported Users",
          isSelected: currentIndex == 2 ? true : false,
        ),
        kHeight15,
        buildNavButton(
          onTap: () {
            context
                .read<NavigationBloc>()
                .add(const NavigateToPageEvent(currentIndex: 3));
          },
          context: context,
          icon: Icons.disabled_visible_outlined,
          text: "Disabled Users",
          isSelected: currentIndex == 3 ? true : false,
        ),
        kHeight15,
        buildNavButton(
          onTap: () {
            context
                .read<NavigationBloc>()
                .add(const NavigateToPageEvent(currentIndex: 4));
          },
          context: context,
          icon: Icons.settings_outlined,
          text: "Settings",
          isSelected: currentIndex == 4 ? true : false,
        ),
      ],
    ),
  );
}

BoxDecoration containerBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: kBlack,
    boxShadow: [
      BoxShadow(
          blurRadius: 2,
          spreadRadius: 1,
          color: kBlack.withOpacity(0.4),
          // color: kLightGreenColor.withOpacity(0.2),
          offset: const Offset(1, 1)),
      BoxShadow(
          blurRadius: 2,
          spreadRadius: 1,
          color: kWhite.withOpacity(0.4),
          // color: kLightGreenColor.withOpacity(0.2),
          offset: const Offset(1, 1))
    ],
  );
}

Widget buildBottomNavigation({
  required BuildContext context,
}) {
  final currentIndex = context.watch<NavigationBloc>().state.currentIndex ?? 0;
  return Container(
    decoration: BoxDecoration(
      color: kBlack,
      boxShadow: [
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: kBlack.withOpacity(0.4),
            offset: const Offset(0, -1)),
      ],
    ),
    child: BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: kBlack,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kLightGreenColor,
      unselectedItemColor: kNotSelectedColor,
      items: [
        buildBottomNavItem(
          icon: Icons.dashboard_rounded,
          label: "Dashboard",
        ),
        buildBottomNavItem(
          icon: Icons.group,
          label: "Users",
        ),
        buildBottomNavItem(
          icon: Icons.disabled_visible_outlined,
          label: "Disabled Users",
        ),
        buildBottomNavItem(
          icon: Icons.report_gmailerrorred_outlined,
          label: "Reported Users",
        ),
        buildBottomNavItem(
          icon: Icons.settings_outlined,
          label: "Settings",
        ),
      ],
      onTap: (currentIndex) {
        context.read<NavigationBloc>().add(
              NavigateToPageEvent(
                currentIndex: currentIndex,
              ),
            );
      },
    ),
  );
}

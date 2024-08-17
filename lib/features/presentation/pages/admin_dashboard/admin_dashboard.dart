import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/core/constants/height_width.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/admin_home/navigation_widgets.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/responsive_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/widgets/common_widgets/text_widget_common.dart';
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a breakpoint for small screens
    const double smallScreenBreakpoint = 600; // Adjust this value as needed

    return Scaffold(
      body: SizedBox(
        width: screenWidth(context: context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: dashboardWelcomNoteAndIcon(
                context: context,
              ),
            ),
            
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Determine the number of columns based on screen width
                  int crossAxisCount = constraints.maxWidth > smallScreenBreakpoint ? 2 : 1;
                  
                  // Adjust childAspectRatio based on the number of columns
                  double childAspectRatio = crossAxisCount == 2 ? 3 : 4;
        
                  return GridView.count(
                    padding: EdgeInsets.symmetric(
                      vertical: getResponsiveHeight(context, 10),horizontal: getResponsiveWidth(context, 10)
                    ),
                    mainAxisSpacing: getResponsiveHeight(context, 30),
                    crossAxisSpacing: getResponsiveWidth(context, 10),
                    childAspectRatio: childAspectRatio,
                    crossAxisCount: crossAxisCount,
                    children: [
                      dashBoardAppDetailGiveContainer(
                        subTitle: '100',
                        title: 'No. of App Users',
                        context: context,
                      ),
                      dashBoardAppDetailGiveContainer(
                        subTitle: '20',
                        title: 'No. of Reported users',
                        context: context,
                      ),
                      dashBoardAppDetailGiveContainer(
                        subTitle: '10',
                        title: 'No. of Disabled users',
                        context: context,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

double getResponsiveWidth(BuildContext context, double baseWidth) {
  return baseWidth * (MediaQuery.of(context).size.width / 375);
}

double getResponsiveHeight(BuildContext context, double baseHeight) {
  return baseHeight * (MediaQuery.of(context).size.height / 812);
}
// (constraints.maxWidth / 2) /
//                                 (constraints.maxHeight / 4)
Widget dashboardWelcomNoteAndIcon({
  required BuildContext context,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: TextWidgetCommon(
          text: 'Welcome Back to Dashboard',
          fontWeight: FontWeight.bold,
          fontSize: responsiveFontSize(context: context, baseSize: 35),
          textColor: kWhite,
        ),
      ),
      const CircleAvatar(
        radius: 20,
        child: Icon(Icons.person),
      )
    ],
  );
}

Widget dashBoardAppDetailGiveContainer({
  required BuildContext context,
  required String title,
  required String subTitle,
}) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: getResponsiveWidth(context, 10),
      vertical: getResponsiveHeight(context, 20),
    ),
    width: screenWidth(context: context) * 0.6,
    decoration: containerBoxDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidgetCommon(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: responsiveFontSize(
            context: context,
            baseSize: 20,
          ),
          textColor: kLightGreenColor,
        ),
        kHeight10,
        TextWidgetCommon(
          text: subTitle,
          fontWeight: FontWeight.bold,
          fontSize: responsiveFontSize(
            context: context,
            baseSize: 20,
          ),
          textColor: kWhite,
        ),
      ],
    ),
  );
}

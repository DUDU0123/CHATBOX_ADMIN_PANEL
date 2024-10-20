import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/config/all_bloc_provider.dart';
import 'package:official_chatbox_admin_application/core/constants/colors.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/main_navigate_page/wrapper_page.dart';
GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
class RootWidgetPage extends StatelessWidget {
  const RootWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(
      providers: AllBlocProvider.allBlocProviders,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'ChatBox Admin Console',
        theme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          scaffoldBackgroundColor: kAdminHomeScaffoldColor,
        ),
        themeMode: ThemeMode.dark,
      home: const WrapperPage(),
      ),
    );
  }
}

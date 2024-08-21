import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/config/imp_keys/service_keys.dart';
import 'package:official_chatbox_admin_application/features/root_widget_page.dart';

Future<void> main() async {
   // Make sure zone errors are fatal before the binding is initialized
  BindingBase.debugZoneErrorsAreFatal = true;
  // Wrapping your app in runZonedGuarded to catch unhandled async errors
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:apiKey,
        appId: appId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        authDomain: authDomain,
        storageBucket: storageBucket,
      ),
    );
    runApp(
      const RootWidgetPage(),
    );
  }, (error, stackTrace) {
  });
}

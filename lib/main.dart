import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/features/root_widget_page.dart';

Future<void> main() async {
   // Make sure zone errors are fatal before the binding is initialized
  
  
  // Wrapping your app in runZonedGuarded to catch unhandled async errors
  runZonedGuarded(() async {
    BindingBase.debugZoneErrorsAreFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyA1ICAy3Bl-2_GRxiVp9yMxxwnGxBekgdM',
        appId: '1:641647769517:web:9295d158eb1662e7705324',
        messagingSenderId: '641647769517',
        projectId: 'new-chat-box-social-app',
        authDomain: 'new-chat-box-social-app.firebaseapp.com',
        storageBucket: 'new-chat-box-social-app.appspot.com',
      ),
    );
    runApp(
      const RootWidgetPage(),
    );
  }, (error, stackTrace) {
    // Handle the error and stack trace here
    log('Caught unhandled error: $error');
    log('Stack trace: $stackTrace');
  });
}

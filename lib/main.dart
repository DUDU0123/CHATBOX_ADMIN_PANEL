import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/features/root_widget_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA1ICAy3Bl-2_GRxiVp9yMxxwnGxBekgdM",
      authDomain: "new-chat-box-social-app.firebaseapp.com",
      projectId: "new-chat-box-social-app",
      storageBucket: "new-chat-box-social-app.appspot.com",
      messagingSenderId: "641647769517",
      appId: "1:641647769517:web:9295d158eb1662e7705324"
    ),
  );
  runApp(
    const RootWidgetPage(),
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_app_flutter/Resources/auth_method.dart';
import 'package:zoom_app_flutter/Screen/home_screen.dart';
import 'package:zoom_app_flutter/Screen/login.dart';
import 'package:zoom_app_flutter/Screen/video_call_screen.dart';
import 'package:zoom_app_flutter/Utils/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        'login': (context) => LoginScreen(),
        'home': (context) => HomeScreen(),
        'video-call': (context) => VideoCallScreen()
      },
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: StreamBuilder(
          stream: AuthMethod().authChange,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }),
    );
  }
}

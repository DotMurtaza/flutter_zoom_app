import 'package:flutter/material.dart';
import 'package:zoom_app_flutter/Resources/auth_method.dart';
import 'package:zoom_app_flutter/Widget/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMethod _authMethod = AuthMethod();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Start or join meeting",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Image.asset("assets/images/onboarding.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomButton(
                onTap: () async {
                  bool res = await _authMethod.signInWithGoogle(context);
                  if (res) {
                    Navigator.pushNamed(context, '/home');
                  }
                },
                text: "Google Sign In"),
          )
        ],
      ),
    );
  }
}

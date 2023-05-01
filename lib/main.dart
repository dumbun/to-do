import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/pages/main_page.dart';
import 'package:to_do/pages/register_page.dart';
import 'pages/email_verfication_page.dart';
import 'pages/login_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Homepage());
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home/": (context) => const MainPage(),
        "/login/": (context) => const LoginPage(),
        "/register/": (context) => RegisterPage(),
        "/verifyEmail/": (context) => const EmailVerfication(),
      },
      home: const LoginPage(),
    );
  }
}

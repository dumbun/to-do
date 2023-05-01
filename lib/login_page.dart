import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/main_page.dart';
import 'package:to_do/widgets/alert_dilog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //// Text Controlers
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  //// login function
  Future login() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      FirebaseAuth.instance.currentUser?.reload();
      Navigator.of(context).pushNamedAndRemoveUntil('/home/', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        GetAlertDialog().singleActionDialog(
          context: context,
          title: "Error",
          content: "Wrong Password",
        );
      } else if (e.code == "invalid-email") {
        GetAlertDialog().registerDoubleActionDialog(
          context: context,
          title: "Error",
          content: "Email Not Found! Please Register.",
        );
      } else {
        GetAlertDialog().singleActionDialog(
            context: context, title: "Error", content: e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //// Logo
                      Image.asset("assets/images/kingdom-sign-in.gif"),

                      const SizedBox(height: 57),

                      //// Hello Again

                      Text(
                        "HELLO AGAIN 🤟",
                        style: GoogleFonts.exo2(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ///// Welcome back, you've been missed!

                      const Text(
                        "Welcome back, you've been missed!",
                        style: TextStyle(fontSize: 18),
                      ),

                      const SizedBox(height: 10),

                      //// email Textfield

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          style: const TextStyle(fontSize: 20.0),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
                          ),
                          controller: _emailController,
                        ),
                      ),

                      //// Password Textfield

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: _passwordController,
                          style: const TextStyle(fontSize: 20.0),
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      //// Login

                      TextButton.icon(
                        style: const ButtonStyle(
                          iconSize: MaterialStatePropertyAll(40),
                        ),
                        onPressed: login,
                        icon: const Icon(Icons.login_rounded),
                        label: const Text(
                          "Log In",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),

                      //// Register Button

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a member?",
                            style: GoogleFonts.exo2(
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                    "/register/", (route) => false),
                            child: const Text(
                              "Register now",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const MainPage();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/widgets/alert_dilog.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  //! controlers

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _verifiedPassword = TextEditingController();

  //! register logic

  void register(context) async {
    final email = _email.text;
    final password = _password.text;
    final verfiedPassword = _verifiedPassword.text;
    if (password == verfiedPassword) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        try {
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
          //// to change the user data to updated data
          await FirebaseAuth.instance.currentUser?.reload();
        } on FirebaseAuthException catch (e) {
          GetAlertDialog().singleActionDialog(
              context: context, title: "Error", content: e.code);
        }

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/verifyEmail/', (route) => false);
      } on FirebaseAuthException catch (e) {
        // email-already-in-use
        if (e.code == "email-already-in-use") {
          return GetAlertDialog().singleActionDialog(
              context: context,
              title: "Email-Error",
              content: "Email Already Exits");
        }
        // invalid-email
        if (e.code == " invalid-email") {
          return GetAlertDialog().singleActionDialog(
              context: context, title: "Email-Error", content: "Invalid Email");
        }
        // weak-password
        if (e.code == "weak-password") {
          return GetAlertDialog().singleActionDialog(
              context: context,
              title: "Password-Error",
              content: "Week Password Choose a Strong Password");
        }
      }
    } else if (password != verfiedPassword) {
      GetAlertDialog().singleActionDialog(
          context: context,
          title: "Password not same ",
          content: "Please enter the same password in both filds ");
    }
  }

  void dispose() {
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //// icon

              const Icon(
                Icons.app_registration_rounded,
                size: 200,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 25,
              ),

              //// Email input field

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  autocorrect: false,
                  controller: _email,
                  style: const TextStyle(fontSize: 25),
                  decoration: const InputDecoration(
                      label: Text(
                    "Enter your Email",
                  )),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //// Password input field

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  autocorrect: false,
                  controller: _password,
                  style: const TextStyle(fontSize: 25),
                  decoration:
                      const InputDecoration(label: Text("Enter your Password")),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //// Verified Password TextField

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  autocorrect: false,
                  controller: _verifiedPassword,
                  style: const TextStyle(fontSize: 25),
                  decoration:
                      const InputDecoration(label: Text("Verify the password")),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              //// register Button

              ElevatedButton(
                onPressed: () {
                  register(context);
                },
                child: const Text(
                  "Please verify your Email",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              //// login route

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Registered!",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login/", (route) => true),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

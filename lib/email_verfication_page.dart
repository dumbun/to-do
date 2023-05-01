import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/widgets/alert_dilog.dart';

class EmailVerfication extends StatelessWidget {
  const EmailVerfication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "We have send an verfication email. Please verify your Email by clicking the verification link. ",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //! options
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //! check verification
                ElevatedButton(
                    onPressed: () async {
                      FirebaseAuth.instance.currentUser?.reload();
                      if (FirebaseAuth.instance.currentUser?.emailVerified ==
                          true) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/home/", (route) => false);
                      } else {
                        GetAlertDialog().singleActionDialog(
                            context: context,
                            title: "Opps!",
                            content: "Please verify your Email");
                      }
                    },
                    child: const Text("verified! Click Here")),
                const SizedBox(
                  width: 20,
                ),
                //! resend the email
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.currentUser
                            ?.sendEmailVerification();
                      } on FirebaseAuthException catch (e) {
                        GetAlertDialog().singleActionDialog(
                            context: context, title: "Error", content: e.code);
                      }
                    },
                    child: const Text("Resend mail !")),
              ],
            ),
            //! logout neesd to remove on final build
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/login/", (route) => true);
              },
              child: const Text(
                "Logout",
              ),
            )
          ],
        ),
      ),
    );
  }
}

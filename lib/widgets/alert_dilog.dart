import 'package:flutter/material.dart';

class GetAlertDialog {
  Future singleActionDialog(
      {required context, required String title, required String content}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text(
              'Try again',
            ),
          )
        ],
      ),
    );
  }

  Future registerDoubleActionDialog(
      {required context, required String title, required String content}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil("/register/", (route) => false),
            child: const Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

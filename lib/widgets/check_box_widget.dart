import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({super.key});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      key: UniqueKey(),
      value: isClicked,
      onChanged: (bool? value) {
        setState(() {
          isClicked = value!;
        });
      },
    );
  }
}

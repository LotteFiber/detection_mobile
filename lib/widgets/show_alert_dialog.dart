import 'package:flutter/material.dart';

class ShowAlertDialog extends StatefulWidget {
  final BuildContext context;
  final String title;
  final String message;
  final String leftTextButton;
  final Function leftOnPressed;
  final String rightTextButton;
  final Function rightOnPressed;

  const ShowAlertDialog({
    Key? key,
    required this.context,
    required this.title,
    required this.message,
    required this.leftTextButton,
    required this.leftOnPressed,
    required this.rightTextButton,
    required this.rightOnPressed,
  }) : super(key: key);

  @override
  State<ShowAlertDialog> createState() => _ShowAlertDialogState();
}

class _ShowAlertDialogState extends State<ShowAlertDialog> {
  @override
  late BuildContext context;
  late String title;
  late String message;
  late String leftTextButton;
  late Function leftOnPressed;
  late String rightTextButton;
  late Function rightOnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            return leftOnPressed();
          },
          child: Text(leftTextButton),
        ),
        TextButton(
          onPressed: () {
            return rightOnPressed();
          },
          child: Text(rightTextButton),
        )
      ],
    );
  }
}

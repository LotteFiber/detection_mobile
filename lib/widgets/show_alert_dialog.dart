// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

void foundDialog(
  BuildContext context,
  String title,
  String message,
  String leftTextButton,
  VoidCallback leftOnPressed,
  String rightTextButton,
  VoidCallback rightOnPressed,
  int count,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 40,
              color: Colors.green,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              message,
              style: GoogleFonts.prompt(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(top: 20.0),
        content: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "จำนวน $count ครั้ง",
                style: GoogleFonts.prompt(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
            onPressed: () {
              return leftOnPressed();
            },
            // child: Text(leftTextButton),
            child: Text(
              leftTextButton,
              style: GoogleFonts.prompt(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black45),
            ),
            style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(238, 241, 247, 1),
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              return rightOnPressed();
            },
            child: Text(
              rightTextButton,
              style: GoogleFonts.prompt(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 15.0),
      );
    },
  );
}

void notFoundDialog(
  BuildContext context,
  String title,
  String message,
  String leftTextButton,
  VoidCallback leftOnPressed,
  String rightTextButton,
  VoidCallback rightOnPressed,
  int count,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.cancel,
              size: 40,
              color: Colors.red,
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(top: 20.0),
        content: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: GoogleFonts.prompt(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
            onPressed: () {
              return leftOnPressed();
            },
            // child: Text(leftTextButton),
            child: Text(
              leftTextButton,
              style: GoogleFonts.prompt(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black45),
            ),
            style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(238, 241, 247, 1),
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              return rightOnPressed();
            },
            child: Text(
              rightTextButton,
              style: GoogleFonts.prompt(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 15.0),
      );
    },
  );
}

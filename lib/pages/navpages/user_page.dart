import 'package:detection_mobile/const/appConst.dart';
import 'package:detection_mobile/utils/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kActiveColor,
          title: Text(
            "ผู้ใช้งาน",
            style: GoogleFonts.prompt(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: kMainColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 40, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppConst.USER_NAME,
                        style: GoogleFonts.prompt(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => {SharedService.logout(context)},
                    child: Text(
                      "ออกจากระบบ",
                      style: GoogleFonts.prompt(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kActiveColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

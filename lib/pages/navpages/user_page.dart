import 'package:detection_mobile/const/appConst.dart';
import 'package:detection_mobile/utils/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(
            "User",
            style: GoogleFonts.prompt(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
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
              // UserName
              // FormHelper.inputFieldWidget(
              //   context,
              //   "userName",
              //   "ชื่อผู้ใช้",
              //       () {},
              //       () {},
              //   showPrefixIcon: true,
              //   prefixIcon: const Icon(Icons.person_outline),
              //   borderRadius: 10,
              //   contentPadding: 15,
              //   fontSize: 14,
              //   prefixIconPaddingLeft: 10,
              //   borderColor: Colors.grey.shade400,
              //   textColor: Colors.black,
              //   prefixIconColor: Colors.black,
              //   hintColor: Colors.black.withOpacity(.6),
              //   backgroundColor: Colors.grey.shade100,
              //   borderFocusColor: Colors.grey.shade400,
              // ),
              // const SizedBox(
              //   height: 24,
              // ),
              // // Phone Number
              // FormHelper.inputFieldWidget(
              //   context,
              //   "phoneNumber",
              //   "โทรศัพท์",
              //       () {},
              //       () {},
              //   showPrefixIcon: true,
              //   prefixIcon: const Icon(Icons.phone),
              //   borderRadius: 10,
              //   contentPadding: 15,
              //   fontSize: 14,
              //   prefixIconPaddingLeft: 10,
              //   borderColor: Colors.grey.shade400,
              //   textColor: Colors.black,
              //   prefixIconColor: Colors.black,
              //   hintColor: Colors.black.withOpacity(.6),
              //   backgroundColor: Colors.grey.shade100,
              //   borderFocusColor: Colors.grey.shade400,
              // ),
              // const SizedBox(
              //   height: 24,
              // ),
              // // Email
              // FormHelper.inputFieldWidget(
              //   context,
              //   "email",
              //   "อีเมลล์",
              //       () {},
              //       () {},
              //   showPrefixIcon: true,
              //   prefixIcon: const Icon(Icons.email_outlined),
              //   borderRadius: 10,
              //   contentPadding: 15,
              //   fontSize: 14,
              //   prefixIconPaddingLeft: 10,
              //   borderColor: Colors.grey.shade400,
              //   textColor: Colors.black,
              //   prefixIconColor: Colors.black,
              //   hintColor: Colors.black.withOpacity(.6),
              //   backgroundColor: Colors.grey.shade100,
              //   borderFocusColor: Colors.grey.shade400,
              // ),
              // // Save Button
              // const SizedBox(
              //   height: 40,
              // ),
              // Center(
              //   child: FormHelper.submitButton(
              //     "บันทึก",
              //         () {},
              //     btnColor: Colors.deepOrangeAccent,
              //     borderColor: Colors.white,
              //     txtColor: Colors.white,
              //     borderRadius: 20,
              //   ),
              // ),
              // const SizedBox(
              //   height: 40,
              // ),
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
                  // ElevatedButton.icon(
                  //   onPressed: () => {SharedService.logout(context)},
                  //   icon: Text(
                  //     "Log Out",
                  //     style: GoogleFonts.prompt(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  //   label: const Icon(Icons.logout),
                  // ),
                  ElevatedButton(
                      onPressed: () => {SharedService.logout(context)},
                      child: Text(
                        "Log Out",
                        style: GoogleFonts.prompt(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrangeAccent)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

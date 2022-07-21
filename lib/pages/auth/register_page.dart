import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import 'package:detection_mobile/api/api_service.dart';
import '../../config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  String? userName;
  String? password;
  String? confirmPassword;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: _registerUI(context),
        ),
        inAsyncCall: isAsyncCallProcess,
        opacity: .3,
        key: UniqueKey(),
      ),
    ));
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "img/helmet.jpg",
                  fit: BoxFit.contain,
                  width: 150,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic,
                    fontSize: 35,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Helmet",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                      text: ".sys",
                      style: GoogleFonts.roboto(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Center(
            child: Text(
              "ลงทะเบียน",
              style: GoogleFonts.prompt(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(
            context,
            "userName",
            "ชื่อผู้ใช้",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* จำเป็น";
              }
              return null;
            },
            (onSavedVal) {
              userName = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.person_outline),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade200,
            textColor: Colors.black,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade400,
          ),
          const SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(
              context,
              "password",
              "รหัสผ่าน",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "* จำเป็น";
                }

                return null;
              },
              (onSavedVal) {
                password = onSavedVal.toString().trim();
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.lock_outlined),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              prefixIconPaddingLeft: 10,
              borderColor: Colors.grey.shade200,
              textColor: Colors.black,
              prefixIconColor: Colors.black,
              hintColor: Colors.black.withOpacity(.6),
              backgroundColor: Colors.grey.shade100,
              borderFocusColor: Colors.grey.shade400,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.redAccent.withOpacity(.4),
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              ),
              onChange: (val) {
                password = val;
              }),
          const SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(
            context,
            "confirmPassword",
            "ยืนยันรหัสผ่าน",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* จำเป็น";
              }
              if (onValidateVal != password) {
                return "รหัสผ่านไม่ตรงกัน";
              }
              return null;
            },
            (onSavedVal) {
              confirmPassword = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.lock_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade200,
            textColor: Colors.black,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade400,
            obscureText: hideConfirmPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hideConfirmPassword = !hideConfirmPassword;
                });
              },
              color: Colors.redAccent.withOpacity(.4),
              icon: Icon(hideConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "ลงทะเบียน",
              () {
                if (validateSave()) {
                  setState(() {
                    isAsyncCallProcess = true;
                  });

                  APIService.registerUser(
                    userName!,
                    password!,
                  ).then(
                    (response) {
                      setState(() {
                        isAsyncCallProcess = false;
                      });

                      if (response) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "ลงทะเบียนสำเร็จ",
                          "Ok",
                          () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/login",
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "ชื่อผู้ใช้นี้ลงทะเบียนไปแล้ว",
                          "Ok",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: Colors.deepOrangeAccent,
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.prompt(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: "มีบัญชีอยู่แล้ว? ", style: GoogleFonts.prompt()),
                  TextSpan(
                    text: "เข้าสู่ระบบ",
                    style: GoogleFonts.prompt(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          "/login",
                          (route) => false,
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateSave() {
    final form = globalKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}

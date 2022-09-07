// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

// Project imports:
import 'package:detection_mobile/api/api_service.dart';
import 'package:detection_mobile/config.dart';
import 'package:detection_mobile/constants.dart';
import 'package:detection_mobile/pages/navpages/data_page.dart';
import 'package:detection_mobile/pages/navpages/detail_page.dart';
import 'package:detection_mobile/widgets/show_alert_dialog.dart';
import 'package:detection_mobile/models/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  DataModel? dataModel;
  String? studentId;
  String? enterdStudentId;

  void _processData() {
    globalKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kActiveColor,
          title: Text(
            "ตรวจสอบข้อมูล",
            style: GoogleFonts.prompt(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: kMainColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: kBgColor,
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: _addHomeUI(context),
          ),
          inAsyncCall: isAsyncCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dataModel = DataModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        dataModel = arguments["model"];
        setState(() {});
      }
    });
  }

  Widget _addHomeUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ตรวจสอบข้อมูลรหัสนิสิต",
                        style: GoogleFonts.prompt(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: kActiveColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FormHelper.inputFieldWidget(
                    context,
                    "studentId",
                    "รหัสนิสิต",
                    (onValidateVal) {
                      String pattern = r'^([0-9]{8})$';
                      if (onValidateVal.isEmpty) {
                        return "* จำเป็น";
                      }
                      if (!RegExp(pattern).hasMatch(onValidateVal)) {
                        return "รหัสนิสิต รูปแบบไม่ถูกต้อง";
                      }
                      return null;
                    },
                    (onSavedVal) {
                      studentId = onSavedVal.toString().trim();
                      enterdStudentId = onSavedVal.toString().trim();
                    },
                    showPrefixIcon: false,
                    borderRadius: 10,
                    contentPadding: 15,
                    fontSize: 14,
                    prefixIconPaddingLeft: 10,
                    borderColor: Colors.grey.shade400,
                    textColor: Colors.black,
                    prefixIconColor: Colors.black,
                    hintColor: Colors.black.withOpacity(.6),
                    backgroundColor: Colors.grey.shade100,
                    borderFocusColor: Colors.grey.shade400,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: FormHelper.submitButton(
                      "ตรวจสอบ",
                      () {
                        if (validateAndSave()) {
                          setState(() {
                            isAsyncCallProcess = true;
                          });

                          APIService.checkData(studentId!).then(
                            (response) {
                              APIService.getCount(studentId!).then(
                                (value) {
                                  setState(() {
                                    isAsyncCallProcess = false;
                                  });

                                  if (response) {
                                    foundDialog(
                                      context,
                                      Config.appName,
                                      "พบข้อมูลนิสิต",
                                      "ดูข้อมูล",
                                      () {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                              studentID:
                                                  enterdStudentId.toString(),
                                            ),
                                          ),
                                        ).then(
                                          (_) =>
                                              globalKey.currentState?.reset(),
                                        );
                                        _processData();
                                        FocusManager.instance.primaryFocus?.unfocus();
                                      },
                                      "เพิ่มข้อมูลใหม่",
                                      () {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DataPage(),
                                          ),
                                        ).then(
                                          (_) =>
                                              globalKey.currentState?.reset(),
                                        );
                                        _processData();
                                        FocusManager.instance.primaryFocus?.unfocus();
                                      },
                                      value,
                                    );
                                  } else {
                                    notFoundDialog(
                                      context,
                                      Config.appName,
                                      "ไม่พบเจอผู้ไม่สวมหมวกนิรภัย",
                                      "ยกเลิก",
                                      () {
                                        Navigator.of(context).pop();
                                        _processData();
                                        FocusManager.instance.primaryFocus?.unfocus();
                                      },
                                      "เพิ่มข้อมูลใหม่",
                                      () {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DataPage(),
                                          ),
                                        ).then(
                                          (_) =>
                                              globalKey.currentState?.reset(),
                                        );
                                        _processData();
                                        FocusManager.instance.primaryFocus?.unfocus();
                                      },
                                      value,
                                    );
                                  }
                                },
                              );
                            },
                          );
                        }
                      },
                      btnColor: kActiveColor,
                      borderColor: Colors.white,
                      txtColor: Colors.white,
                      borderRadius: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:io';
import 'package:detection_mobile/models/student_model.dart';
import 'package:detection_mobile/pages/navpages/detail_page.dart';
import 'package:detection_mobile/pages/navpages/data_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../api/api_service.dart';
import '../../config.dart';
import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  StudentModel? studentModel;
  String? studentId;
  String? enterdStudentId;
  bool isImageSelected = false;
  bool isFileSelected = false;
  XFile? file;

  String faculty = "";
  String province = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(
            "Check Data",
            style: GoogleFonts.prompt(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
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
    studentModel = StudentModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        studentModel = arguments["model"];
        setState(() {});
      }
    });
  }

  Widget _addHomeUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "check student id",
                        style: GoogleFonts.prompt(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.deepOrangeAccent,
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
                    "student id",
                    (onValidateVal) {
                      String pattern = r'^[0-9]{8}';
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
                      "check",
                      () {
                        if (validateAndSave()) {
                          setState(() {
                            isAsyncCallProcess = true;
                          });

                          APIService.checkData(studentId!).then(
                            (response) {
                              APIService.getCount(studentId!).then((value) {
                                setState(() {
                                  isAsyncCallProcess = false;
                                });

                                if (response) {
                                  showNewDiAlertDialog(
                                      context,
                                      Config.appName,
                                      "พบเจอผู้ไม่สวมหมวกนิรภัย ",
                                      "เพิ่มข้อมูลใหม่",
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ScanPage()));
                                      },
                                      "ดูข้อมูล",
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                      studentID: enterdStudentId
                                                          .toString(),
                                                    )));
                                      },
                                      value);
                                } else {
                                  showNewNotDiAlertDialog(
                                      context,
                                      Config.appName,
                                      "ไม่พบเจอผู้ไม่สวมหมวกนิรภัย ",
                                      "เพิ่มข้อมูลใหม่",
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ScanPage()));
                                      },
                                      "ยกเลิก",
                                      () {
                                        Navigator.of(context).pop();
                                      },
                                      value);
                                }
                              });
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
                    height: 15,
                  ),
                  // Center(
                  //   child: FormHelper.submitButton(
                  //     "add student",
                  //     () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => const StudentPage()));
                  //     },
                  //     btnColor: Colors.orange,
                  //     borderColor: Colors.white,
                  //     txtColor: Colors.white,
                  //     borderRadius: 20,
                  //     width: 250,
                  //   ),
                  // ),
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

  static Widget picPicker(
    bool isFileSelected,
    String fileName,
    Function onFilePicked,
  ) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isFileSelected
                ? Image.file(
                    File(fileName),
                    height: 200,
                    width: 200,
                  )
                : SizedBox(
                    child: Image.network(
                      fileName,
                      height: 200,
                      width: 200,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.scaleDown,
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35,
              width: 35,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.image,
                  size: 35,
                ),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.gallery);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35,
              width: 35,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.camera,
                  size: 35,
                ),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.camera);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            )
          ],
        )
      ],
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

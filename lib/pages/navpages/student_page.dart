import 'dart:io';
import 'package:detection_mobile/models/data_model.dart';
import 'package:detection_mobile/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../api/api_service.dart';
import '../../config.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPage();
}

class _StudentPage extends State<StudentPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  StudentModel? studentModel;
  DataModel? dataModel;
  String? firstName;
  String? lastName;
  String? studentId;
  String? faculty;
  String? licensePartOne;
  String? licensePartTwo;
  String? licensePartThree;
  bool isImageSelected = false;
  bool isFileSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
          //     "/home",
          //     (route) => false,
          //   ),
          // ),
          title: Text(
            "Add Student",
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
            child: _addStudentUI(context),
          ),
          inAsyncCall: isAsyncCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _addStudentUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "student id card",
                    style: GoogleFonts.prompt(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  picPicker(
                      isImageSelected, studentModel?.uploadedCardImages ?? "",
                      (file) {
                    setState(() {
                      studentModel!.uploadedCardImages = file.path;
                      isImageSelected = true;
                    });
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: FormHelper.submitButton(
                      "verify",
                      () {
                        // if (validateAndSave()) {
                        //   setState(() {
                        //     isAsyncCallProcess = true;
                        //   });
                        APIService.addIdCard(studentModel!, isImageSelected)
                            .then(
                          (response) {
                            setState(() {
                              isAsyncCallProcess = false;
                            });
                            if (response) {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "บันทึกข้อมูลสำเร็จ",
                                "Ok",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "กรุณากรอกข้อมูลให้ถูกต้อง",
                                "Ok",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                        );
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
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "motorcycle license",
                    style: GoogleFonts.prompt(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  picPicker(
                      isImageSelected, studentModel?.uploadedCardImages ?? "",
                      (file) {
                    setState(() {
                      studentModel!.uploadedCardImages = file.path;
                      isImageSelected = true;
                    });
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: FormHelper.submitButton(
                      "verify",
                      () {
                        // if (validateAndSave()) {
                        //   setState(() {
                        //     isAsyncCallProcess = true;
                        //   });
                        APIService.addPlateImage(dataModel!, isImageSelected)
                            .then(
                          (response) {
                            setState(() {
                              isAsyncCallProcess = false;
                            });
                            if (response) {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "บันทึกข้อมูลสำเร็จ",
                                "Ok",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "กรุณากรอกข้อมูลให้ถูกต้อง",
                                "Ok",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                        );
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
                ],
              ),
            ],
          ),
          Container(
            child: Column(
              children: [
                FormHelper.inputFieldWidget(
                  context,
                  "firstName",
                  "first name",
                  (onValidateVal) {
                    String pattern =
                        r"^[A-Za-z]+(([,.] |[ '-])[A-Za-z]+)*([.,'-]?)$";
                    if (onValidateVal.isEmpty) {
                      return "* จำเป็น";
                    }
                    if (!RegExp(pattern).hasMatch(onValidateVal)) {
                      return "ชื่อ รูปแบบไม่ถูกต้อง";
                    }
                    return null;
                  },
                  (onSavedVal) {
                    firstName = onSavedVal.toString().trim();
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
                  height: 10,
                ),
                FormHelper.inputFieldWidget(
                  context,
                  "lastName",
                  "last name",
                  (onValidateVal) {
                    String pattern =
                        r"^[A-Za-z]+(([,.] |[ '-])[A-Za-z]+)*([.,'-]?)$";
                    if (onValidateVal.isEmpty) {
                      return "* จำเป็น";
                    }
                    if (!RegExp(pattern).hasMatch(onValidateVal)) {
                      return "นามสกุล รูปแบบไม่ถูกต้อง";
                    }
                    return null;
                  },
                  (onSavedVal) {
                    lastName = onSavedVal.toString().trim();
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
                  height: 10,
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
                  height: 10,
                ),
                FormHelper.dropDownWidget(
                  context,
                  "faculty",
                  "",
                  Config.facultyList,
                  (onChanged) {
                    faculty = onChanged! ?? "";
                  },
                  (onValidate) {
                    if (onValidate == null) {
                      return "* จำเป็น";
                    }
                    return null;
                  },
                  showPrefixIcon: false,
                  borderRadius: 10,
                  contentPadding: 15,
                  hintFontSize: 15,
                  prefixIconPaddingLeft: 10,
                  borderColor: Colors.grey.shade400,
                  textColor: Colors.black,
                  prefixIconColor: Colors.black,
                  hintColor: Colors.black.withOpacity(.6),
                  borderFocusColor: Colors.grey.shade400,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormHelper.inputFieldWidget(
                  context,
                  "licensePartOne",
                  "licensePartOne",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return "* จำเป็น";
                    }
                    return null;
                  },
                  (onSavedVal) {
                    licensePartOne = onSavedVal.toString().trim();
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
                  height: 10,
                ),
                FormHelper.dropDownWidget(
                  context,
                  "licensePartTwo",
                  "",
                  Config.cityList,
                  (onChanged) {
                    licensePartTwo = onChanged! ?? "";
                  },
                  (onValidate) {
                    if (onValidate == null) {
                      return "* จำเป็น";
                    }
                    return null;
                  },
                  showPrefixIcon: false,
                  borderRadius: 10,
                  contentPadding: 15,
                  hintFontSize: 15,
                  prefixIconPaddingLeft: 10,
                  borderColor: Colors.grey.shade400,
                  textColor: Colors.black,
                  prefixIconColor: Colors.black,
                  hintColor: Colors.black.withOpacity(.6),
                  borderFocusColor: Colors.grey.shade400,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormHelper.inputFieldWidget(
                  context,
                  "licensePartThree",
                  "licensePartThree",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return "* จำเป็น";
                    }
                    return null;
                  },
                  (onSavedVal) {
                    licensePartThree = onSavedVal.toString().trim();
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
                  height: 20,
                ),
                Center(
                  child: FormHelper.submitButton(
                    "save",
                    () {
                      if (validateAndSave()) {
                        setState(() {
                          isAsyncCallProcess = true;
                        });
                        APIService.addStudent(
                          firstName!,
                          lastName!,
                          studentId!,
                          faculty!,
                          licensePartOne!,
                          licensePartTwo!,
                          licensePartThree!,
                        ).then(
                          (response) {
                            setState(() {
                              isAsyncCallProcess = false;
                            });

                            if (response) {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "บันทึกข้อมูลสำเร็จ",
                                "Ok",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "กรุณากรอกข้อมูลให้ถูกต้อง",
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
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    studentModel = StudentModel();
    dataModel = DataModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        studentModel = arguments["model"];
        dataModel = arguments["model"];
        setState(() {});
      }
    });
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

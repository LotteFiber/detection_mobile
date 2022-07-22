import 'dart:async';
import 'dart:io';
import 'package:detection_mobile/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../api/api_service.dart';
import '../../config.dart';
import '../../models/data_model.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _DataPageState();
}

class _DataPageState extends State<ScanPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  DataModel? dataModel;
  StudentModel? studentModel;
  String? firstName;
  String? lastName;
  String? studentId;
  String? faculty;
  String? licensePartOne;
  String? licensePartTwo;
  String? licensePartThree;
  bool isImageSelected = false;
  bool isFileSelected = false;
  XFile? file;

  String province = "";
  String chargeVal = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // systemOverlayStyle:
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(
            "Add Data",
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
            child: _addDataUI(context),
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

  Widget _addDataUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "motorcycle plate",
                            style: GoogleFonts.prompt(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          picPicker(
                            isImageSelected,
                            dataModel!.uploadedImages ?? "",
                            (file) {
                              setState(
                                () {
                                  dataModel!.uploadedImages = file.path;
                                  isImageSelected = true;
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: FormHelper.submitButton(
                              "verify",
                              () {
                                if (isImageSelected) {
                                  setState(() {
                                    isAsyncCallProcess = true;
                                  });
                                  APIService.addPlateImage(
                                          dataModel!, isImageSelected)
                                      .then(
                                    (response) {
                                      Timer(const Duration(seconds: 10), () {
                                        setState(() {
                                          isAsyncCallProcess = false;
                                        });
                                      });
                                      if (response) {
                                        Timer(const Duration(seconds: 10), () {
                                          FormHelper.showSimpleAlertDialog(
                                            context,
                                            Config.appName,
                                            "คลิก Ok เพื่อกรอกฟอร์มข้อมูลอัตโนมัติ",
                                            "Ok",
                                            () {
                                              APIService.getImageData()
                                                  .then((response2) {
                                                if (response2 != null) {
                                                  print(response2);
                                                  // var jsonData =
                                                  //     json.decode(response2.body);
                                                  setState(() {
                                                    dataModel!.licensePartOne =
                                                        response2["top"];
                                                    province =
                                                        response2["province"];
                                                    dataModel!
                                                            .licensePartThree =
                                                        response2["bottom"];
                                                    chargeVal =
                                                        "ไม่สวมหมวกนิรภัย";
                                                  });
                                                }
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        });
                                      } else {
                                        FormHelper.showSimpleAlertDialog(
                                          context,
                                          Config.appName,
                                          "Please Provide Valid Data",
                                          "Ok",
                                          () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "Please Select Image",
                                    "Ok",
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              },
                              width: 100,
                              height: 40,
                              btnColor: Colors.deepOrangeAccent,
                              borderColor: Colors.white,
                              txtColor: Colors.white,
                              borderRadius: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "student card",
                            style: GoogleFonts.prompt(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          picPicker(
                            isImageSelected,
                            dataModel!.uploadedImages ?? "",
                            (file) {
                              setState(
                                () {
                                  dataModel!.uploadedImages = file.path;
                                  isImageSelected = true;
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: FormHelper.submitButton(
                              "verify",
                              () {
                                if (isImageSelected) {
                                  setState(() {
                                    isAsyncCallProcess = true;
                                  });
                                  APIService.addPlateImage(
                                          dataModel!, isImageSelected)
                                      .then(
                                    (response) {
                                      Timer(const Duration(seconds: 10), () {
                                        setState(() {
                                          isAsyncCallProcess = false;
                                        });
                                      });
                                      if (response) {
                                        Timer(const Duration(seconds: 10), () {
                                          FormHelper.showSimpleAlertDialog(
                                            context,
                                            Config.appName,
                                            "คลิก Ok เพื่อกรอกฟอร์มข้อมูลอัตโนมัติ",
                                            "Ok",
                                            () {
                                              APIService.getImageData()
                                                  .then((response2) {
                                                if (response2 != null) {
                                                  print(response2);
                                                  // var jsonData =
                                                  //     json.decode(response2.body);
                                                  setState(() {
                                                    dataModel!.licensePartOne =
                                                        response2["top"];
                                                    province =
                                                        response2["province"];
                                                    dataModel!
                                                            .licensePartThree =
                                                        response2["bottom"];
                                                    chargeVal =
                                                        "ไม่สวมหมวกนิรภัย";
                                                  });
                                                }
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        });
                                      } else {
                                        FormHelper.showSimpleAlertDialog(
                                          context,
                                          Config.appName,
                                          "Please Provide Valid Data",
                                          "Ok",
                                          () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "Please Select Image",
                                    "Ok",
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              },
                              width: 100,
                              height: 40,
                              btnColor: Colors.deepOrangeAccent,
                              borderColor: Colors.white,
                              txtColor: Colors.white,
                              borderRadius: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "event",
                            style: GoogleFonts.prompt(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          picPicker(
                              isImageSelected, dataModel!.uploadedImages ?? "",
                              (file) {
                            setState(() {
                              dataModel!.uploadedImages = file.path;
                              isImageSelected = true;
                            });
                          }),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormHelper.inputFieldWidget(
                    context,
                    "firstName",
                    "first name",
                    (onValidateVal) {
                      String pattern =
                          r"^[A-Za-z]+(([,.] |[ '-])[A-Za-z]+)*([.,'-]?)$";
                      // if (onValidateVal.isEmpty) {
                      //   return "* จำเป็น";
                      // }
                      // if (!RegExp(pattern).hasMatch(onValidateVal)) {
                      //   return "ชื่อ รูปแบบไม่ถูกต้อง";
                      // }
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
                      // if (onValidateVal.isEmpty) {
                      //   return "* จำเป็น";
                      // }
                      // if (!RegExp(pattern).hasMatch(onValidateVal)) {
                      //   return "นามสกุล รูปแบบไม่ถูกต้อง";
                      // }
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
                      // if (onValidateVal.isEmpty) {
                      //   return "* จำเป็น";
                      // }
                      // if (!RegExp(pattern).hasMatch(onValidateVal)) {
                      //   return "รหัสนิสิต รูปแบบไม่ถูกต้อง";
                      // }
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
                      // if (onValidate == null) {
                      //   return "* จำเป็น";
                      // }
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
                      dataModel!.licensePartOne = onSavedVal.toString().trim();
                    },
                    initialValue: dataModel!.licensePartOne ?? "",
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
                    province,
                    Config.cityList,
                    (onChanged) {
                      dataModel!.licensePartTwo = onChanged! ?? "";
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
                      dataModel!.licensePartThree =
                          onSavedVal.toString().trim();
                    },
                    initialValue: dataModel!.licensePartThree ?? "",
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
                    "charge",
                    chargeVal,
                    Config.chargeList,
                    (onChanged) {
                      dataModel!.charge = onChanged! ?? "";
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
                    height: 15,
                  ),
                  Center(
                    child: FormHelper.submitButton(
                      "save",
                      () {
                        if (validateAndSave()) {
                          setState(() {
                            isAsyncCallProcess = true;
                          });
                          APIService.addData(dataModel!).then(
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
                    height: 20,
                  ),
                ],
              ),
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
                    height: 100,
                    width: 100,
                  )
                : SizedBox(
                    child: Image.network(
                      fileName,
                      height: 100,
                      width: 100,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.asset(
                  "img/ui_add_image_photo_picture.webp",
                  height: 50,
                  width: 50,
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

// ignore_for_file: non_constant_identifier_names

// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

// Project imports:
import 'package:detection_mobile/api/api_service.dart';
import 'package:detection_mobile/config.dart';
import 'package:detection_mobile/const/appConst.dart';
import 'package:detection_mobile/constants.dart';
import 'package:detection_mobile/models/datawoplate_model.dart';

class DataWOPlatePage extends StatefulWidget {
  const DataWOPlatePage({Key? key}) : super(key: key);

  @override
  State<DataWOPlatePage> createState() => _DataWOPlatePage();
}

class _DataWOPlatePage extends State<DataWOPlatePage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  DataWOPlateModel? dataWOPlateModel;
  bool isImageSelected = false;
  bool isFileSelected = false;
  XFile? file;
  XFile? file2;
  String CardImage_UUID = "";
  String EventImage_UUID = "";

  void _clearFormData() {
    setState(() {
      dataWOPlateModel?.firstName = "";
      dataWOPlateModel?.lastName = "";
      dataWOPlateModel?.studentId = "";
      dataWOPlateModel?.faculty = "";
      dataWOPlateModel?.charge = "";
      dataWOPlateModel?.uploadedImageCard = null;
      dataWOPlateModel?.uploadedImageEvent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // systemOverlayStyle:
          backgroundColor: kActiveColor,
          title: Text(
            "บันทึกข้อมูล",
            style: GoogleFonts.prompt(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: kBgColor,
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: _addDataWOPlateUI(context),
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
    dataWOPlateModel = DataWOPlateModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        dataWOPlateModel = arguments["model"];
        setState(() {});
      }
    });
  }

  Widget _addDataWOPlateUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Text(
                  "กรณีไม่มีข้อมูลแผ่นป้ายทะเบียน",
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "บัตรนิสิต",
                      style: GoogleFonts.prompt(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: kActiveColor,
                      ),
                    ),
                    picPicker(
                      isImageSelected,
                      dataWOPlateModel!.uploadedImageCard ?? "",
                      (file) {
                        setState(
                          () {
                            dataWOPlateModel!.uploadedImageCard = file.path;
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
                        "ตรวจสอบ",
                        () {
                          if (isImageSelected) {
                            setState(() {
                              isAsyncCallProcess = true;
                            });
                            APIService.addCardImage(
                                    dataWOPlateModel!, isImageSelected)
                                .then(
                              (response) {
                                Timer(const Duration(seconds: 20), () {
                                  setState(() {
                                    isAsyncCallProcess = false;
                                  });
                                });
                                if (response) {
                                  Timer(const Duration(seconds: 20), () {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "คลิก Ok เพื่อกรอกฟอร์มข้อมูลอัตโนมัติ",
                                        "Ok", () {
                                      APIService.getCardImageData()
                                          .then((response2) {
                                        if (response2 != null) {
                                          print(response2);
                                          var pathStr = dataWOPlateModel!
                                              .uploadedImageCard
                                              .toString();
                                          setState(() {
                                            dataWOPlateModel!.firstName =
                                                response2["first_name"];
                                            dataWOPlateModel!.lastName =
                                                response2["last_name"];
                                            dataWOPlateModel!.studentId =
                                                response2["student_id"]
                                                    .toString();
                                            dataWOPlateModel!.faculty =
                                                response2["faculty"];
                                            dataWOPlateModel!.charge =
                                                "ไม่สวมหมวกนิรภัย";
                                            dataWOPlateModel!
                                                    .uploadedImageCardUUID =
                                                AppConst.Temp_UUID +
                                                    "." +
                                                    pathStr.split(".").last;
                                            AppConst.Temp_UUID = "";
                                          });
                                        } else if (response2 == null) {
                                          FormHelper.showSimpleAlertDialog(
                                            context,
                                            Config.appName,
                                            "ไม่สามารถดึงข้อมูลจากภาพนี้ได้ โปรดลองภาพอื่น",
                                            "Ok",
                                            () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        }
                                      });
                                      Navigator.of(context).pop();
                                    });
                                  });
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "โปรดระบุข้อมูลที่ถูกต้อง",
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
                              "กรุณาเลือกรูปภาพ",
                              "Ok",
                              () {
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        },
                        width: 100,
                        height: 40,
                        btnColor: kActiveColor,
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
                      "เหตุการณ์",
                      style: GoogleFonts.prompt(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    picPicker(isImageSelected,
                        dataWOPlateModel!.uploadedImageEvent ?? "", (file2) {
                      setState(() {
                        dataWOPlateModel!.uploadedImageEvent = file2.path;
                        isImageSelected = true;
                      });
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: FormHelper.submitButton(
                        "อัปโหลด",
                        () {
                          if (isImageSelected) {
                            setState(() {
                              isAsyncCallProcess = true;
                            });
                            APIService.uploadImageEventInDataWOPlate(
                                    dataWOPlateModel!, isImageSelected)
                                .then(
                              (response) {
                                setState(() {
                                  isAsyncCallProcess = false;
                                });
                                if (response.isNotEmpty) {
                                  String uuid = response;
                                  EventImage_UUID = uuid;
                                  dataWOPlateModel!.uploadedImageEventUUID =
                                      uuid;
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "อัปโหลดรูปภาพสำเร็จ",
                                    "Ok",
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "โปรดระบุข้อมูลที่ถูกต้อง",
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
                              "กรุณาเลือกรูปภาพ",
                              "Ok",
                              () {
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        },
                        width: 100,
                        height: 40,
                        btnColor: kActiveColor,
                        borderColor: Colors.white,
                        txtColor: Colors.white,
                        borderRadius: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FormHelper.inputFieldWidget(
              context,
              "firstNameVal",
              "ชื่อ",
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
                dataWOPlateModel!.firstName = onSavedVal.toString().trim();
              },
              initialValue: dataWOPlateModel!.firstName ?? "",
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
              "lastNameVal",
              "นามสกุล",
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
                dataWOPlateModel!.lastName = onSavedVal.toString().trim();
              },
              initialValue: dataWOPlateModel!.lastName ?? "",
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
              "studentIdVal",
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
                dataWOPlateModel!.studentId = onSavedVal.toString().trim();
              },
              initialValue: dataWOPlateModel!.studentId ?? "",
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
              "คณะ",
              dataWOPlateModel!.faculty,
              Dropdown.facultyList,
              (onChanged) {
                dataWOPlateModel!.faculty = onChanged! ?? "";
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
            FormHelper.dropDownWidget(
              context,
              "ข้อหา",
              dataWOPlateModel!.charge,
              Dropdown.chargeList,
              (onChanged) {
                dataWOPlateModel!.charge = onChanged! ?? "";
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
            Center(
              child: FormHelper.submitButton(
                "บันทึก",
                () {
                  if (validateAndSave()) {
                    setState(() {
                      isAsyncCallProcess = true;
                    });
                    APIService.addDataWOPlate(
                            dataWOPlateModel!, isImageSelected)
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
                              _clearFormData();
                            },
                          );
                        } else {
                          FormHelper.showSimpleAlertDialog(
                            context,
                            Config.appName,
                            "หาบุคคลไม่เจอ",
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
                btnColor: kActiveColor,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 20,
              ),
            ),
            const SizedBox(
              height: 10,
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

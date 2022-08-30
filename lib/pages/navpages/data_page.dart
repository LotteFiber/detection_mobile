import 'dart:async';
import 'dart:io';
import 'package:detection_mobile/const/appConst.dart';
import 'package:detection_mobile/constants.dart';
import 'package:detection_mobile/models/datawoplate_model.dart';
import 'package:detection_mobile/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../api/api_service.dart';
import '../../config.dart';
import '../../models/data_model.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  DataModel? dataModel;
  StudentModel? studentModel;
  DataWOPlateModel? dataWOPlateModel;
  String? firstName;
  String? lastName;
  String? studentId;
  String? faculty;
  String? licensePartOne = "";
  String? licensePartTwo = "";
  String? licensePartThree = "";
  bool isImageSelected = false;
  bool isFileSelected = false;
  XFile? file;

  XFile? file2;
  XFile? file3;
  XFile? file4;

  String province = "";
  String chargeVal = "";

  String CardImage_UUID = "";
  String EventImage_UUID = "";

  String fName = "";
  String lName = "";
  String sID = "";
  String fValue = "";
  String plateID = "";
  String cardID = "";

  void _processData() {
    globalKey.currentState?.reset();
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
    studentModel = StudentModel();

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
              height: 15,
            ),
            Column(
              children: [
                Text(
                  "กรณีมีข้อมูลแผ่นป้ายทะเบียน",
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
                      "แผ่นป้ายทะเบียน",
                      style: GoogleFonts.prompt(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: kActiveColor,
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
                        "ตรวจสอบ",
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
                                            var pathStr = dataModel!
                                                .uploadedImages
                                                .toString();
                                            // var jsonData =
                                            //     json.decode(response2.body);
                                            setState(() {
                                              dataModel!.licensePartOne =
                                                  response2["top"];
                                              province = response2["province"];
                                              dataModel!.licensePartThree =
                                                  response2["bottom"];
                                              chargeVal = "ไม่สวมหมวกนิรภัย";
                                              dataModel!.imageUUID =
                                                  AppConst.Temp_UUID +
                                                      "." +
                                                      pathStr.split(".").last;
                                              dataModel!.licensePartTwo =
                                                  province;
                                              dataModel!.charge = chargeVal;
                                              AppConst.Temp_UUID = "";
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
                                    "กรุณาระบุข้อมูลที่ถูกต้อง",
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
                      "บัตรนิสิต",
                      style: GoogleFonts.prompt(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    picPicker(
                      isImageSelected,
                      dataModel!.uploadedImageCard ?? "",
                      (file2) {
                        setState(
                          () {
                            dataModel!.uploadedImageCard = file2.path;
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
                        "อัปโหลด",
                        () {
                          if (isImageSelected) {
                            setState(() {
                              isAsyncCallProcess = true;
                            });

                            APIService.uploadImageCard(
                                    dataModel!, isImageSelected)
                                .then(
                              (response) {
                                setState(() {
                                  isAsyncCallProcess = false;
                                });
                                if (response.isNotEmpty) {
                                  String uuid = response;
                                  CardImage_UUID = uuid;
                                  dataModel!.uploadedImageCardUUID = uuid;
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "กรุณาระบุข้อมูลที่ถูกต้อง",
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
                    picPicker(
                        isImageSelected, dataModel!.uploadedImageEvent ?? "",
                        (file3) {
                      setState(() {
                        dataModel!.uploadedImageEvent = file3.path;
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

                            APIService.uploadImageEvent(
                                    dataModel!, isImageSelected)
                                .then(
                              (response) {
                                setState(() {
                                  isAsyncCallProcess = false;
                                });
                                if (response.isNotEmpty) {
                                  String uuid = response;
                                  EventImage_UUID = uuid;
                                  dataModel!.uploadedImageEventUUID = uuid;
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "กรุณาระบุข้อมูลที่ถูกต้อง",
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
              "licensePartOne",
              "แผ่นป้ายทะเบียนส่วนที่ 1",
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
              "แผ่นป้ายทะเบียนส่วนที่ 2",
              province,
              Dropdown.provinceList,
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
              "แผ่นป้ายทะเบียนส่วนที่ 3",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "* จำเป็น";
                }
                return null;
              },
              (onSavedVal) {
                dataModel!.licensePartThree = onSavedVal.toString().trim();
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
              "ข้อหา",
              chargeVal,
              Dropdown.chargeList,
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
                    APIService.addData(dataModel!, isImageSelected).then(
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
                              _processData();
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

  bool validateAndSave2() {
    final form2 = globalKey2.currentState;

    if (form2!.validate()) {
      form2.save();
      return true;
    } else {
      return false;
    }
  }
}

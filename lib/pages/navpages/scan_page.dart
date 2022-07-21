import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  DataModel? dataModel;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Motorcycle License",
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  picPicker(isImageSelected, dataModel!.uploadedImages ?? "",
                      (file) {
                    setState(() {
                      dataModel!.uploadedImages = file.path;
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
                        if (isImageSelected) {
                          setState(() {
                            isAsyncCallProcess = true;
                          });
                          APIService.addPlateImage(dataModel!, isImageSelected)
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
                                            province = response2["province"];
                                            chargeVal = "ไม่สวมหมวกนิรภัย";
                                            dataModel!.licensePartThree =
                                                response2["bottom"];
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
                      btnColor: Colors.deepOrangeAccent,
                      borderColor: Colors.white,
                      txtColor: Colors.white,
                      borderRadius: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "",
                        style: GoogleFonts.prompt(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
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
                    height: 30,
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

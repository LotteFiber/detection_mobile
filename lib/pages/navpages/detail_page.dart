// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:intl/intl.dart';
import 'package:detection_mobile/constants.dart';
import 'package:detection_mobile/pages/navpages/data_page.dart';

import '../../config.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  String studentID;
  DetailPage({
    Key? key,
    required this.studentID,
  }) : super(key: key);

  Future<List<Data>?> _getDatas() async {
    // if (kDebugMode) {
    //   print("Start !" + studentID);
    // }
    var url = Uri.http(Config.apiURL, Config.showDataDetails + "/" + studentID);
    var dataObj = await http.get(url);

    var jsonData = json.decode(dataObj.body);
    // if (kDebugMode) {
    //   print("Start !" + jsonData.length.toString());
    // }
    List<Data> datas = [];
    for (var d in jsonData) {
      Data data = Data(
        d["first_name"],
        d["last_name"],
        d["faculty"],
        d["student_id"],
        d["licensepartone"],
        d["licenseparttwo"],
        d["licensepartthree"],
        d["charge"],
        d["date_data"],
      );
      datas.add(data);
    }

    return datas;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(
            "ผลการตรวจสอบการกระทำความผิด",
            style: GoogleFonts.prompt(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [
            Column(
              children: [
                FutureBuilder(
                  future: _getDatas(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: Text("Loading..."));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var firstNameCap =
                              "${snapshot.data[index].first_name}".capitalize();
                          var lastNameCap =
                              "${snapshot.data[index].last_name}".capitalize();
                          var license = "${snapshot.data[index].licensepartone}"
                              " "
                              "${snapshot.data[index].licenseparttwo}"
                              " "
                              "${snapshot.data[index].licensepartthree}";
                          var studentId = "${snapshot.data[index].student_id}";
                          var faculty = "${snapshot.data[index].faculty}";
                          var charge = "${snapshot.data[index].charge}";
                          var date = snapshot.data[index].date_data;
                          var dateParse = DateTime.parse(date).toLocal();
                          var dateFormatted = DateFormat('dd-MM-yyyy | kk:mm')
                              .format(dateParse);
                          // if (kDebugMode) {
                          //   print(date);
                          //   print(dateParse);
                          //   print(dateFormatted);
                          //   print(DateTime.now());
                          // }
                          return ListTile(
                            leading: const Icon(
                              Icons.warning,
                              color: kActiveColor,
                              size: 25,
                            ),
                            minLeadingWidth: 5,
                            title: Text(
                              firstNameCap +
                                  " " +
                                  lastNameCap +
                                  "\n" +
                                  studentId +
                                  "\n" +
                                  faculty,
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: kBodyTextColor,
                              ),
                            ),
                            subtitle: const Divider(
                              thickness: 1,
                            ),
                            trailing: Text(
                              license + "\n" + charge + "\n" + dateFormatted,
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: kBodyTextColor,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
            Center(
              child: FormHelper.submitButton(
                "เพิ่มข้อมูลใหม่",
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DataPage()));
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
    );
  }
}

class Data {
  final String first_name;
  final String last_name;
  final String faculty;
  final String student_id;
  final String licensepartone;
  final String licenseparttwo;
  final String licensepartthree;
  final String charge;
  final String date_data;

  Data(
    this.first_name,
    this.last_name,
    this.faculty,
    this.student_id,
    this.licensepartone,
    this.licenseparttwo,
    this.licensepartthree,
    this.charge,
    this.date_data,
  );
}

extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

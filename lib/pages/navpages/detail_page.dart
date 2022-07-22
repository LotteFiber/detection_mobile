import 'dart:convert';

import 'package:detection_mobile/pages/navpages/data_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../config.dart';

class DetailPage extends StatelessWidget {
  String studentID;
  DetailPage({Key? key, required this.studentID}) : super(key: key);

  Future<List<Data>?> _getDatas() async {
    if (kDebugMode) {
      print("Start !" + studentID);
    }
    var url = Uri.http(Config.apiURL, Config.showDataDetails + "/" + studentID);
    var dataObj = await http.get(url);

    var jsonData = json.decode(dataObj.body);
    if (kDebugMode) {
      print("Start !" + jsonData.length.toString());
    }
    List<Data> datas = [];
    for (var d in jsonData) {
      Data data = Data(
          d["first_name"],
          d["last_name"],
          d["faculty"],
          d["student_id"],
          d["licensepartone"],
          d["licenseparttwo"],
          d["licensepartthree"]);

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // margin: const EdgeInsets.all(20),
                // padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: _getDatas(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(child: Text("Loading..."));
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var firstNameCap =
                                  "${snapshot.data[index].first_name}"
                                      .capitalize();
                              var lastNameCap =
                                  "${snapshot.data[index].last_name}"
                                      .capitalize();
                              var license =
                                  "${snapshot.data[index].licensepartone}"
                                  " "
                                  "${snapshot.data[index].licenseparttwo}"
                                  " "
                                  "${snapshot.data[index].licensepartthree}";
                              return ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(
                                    Icons.warning,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.deepOrangeAccent,
                                ),
                                title: Text(firstNameCap + " " + lastNameCap),
                                subtitle: Text(snapshot.data[index].student_id),
                                trailing: Text(license),
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              Center(
                child: FormHelper.submitButton(
                  "เพิ่มข้อมูลใหม่",
                  () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScanPage()));
                  },
                  btnColor: Colors.deepOrangeAccent,
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _studentFilters() {
    return Row(
      children: [
        Flexible(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "ค้นหา",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              fillColor: const Color(0xffe6e6ec),
              filled: true,
            ),
          ),
        ),
      ],
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

  Data(this.first_name, this.last_name, this.faculty, this.student_id,
      this.licensepartone, this.licenseparttwo, this.licensepartthree);
}

extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

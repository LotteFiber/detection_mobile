import 'package:flutter/material.dart';
import 'package:detection_mobile/constants.dart';
import 'package:detection_mobile/size_config.dart';
import 'package:detection_mobile/pages/navpages/home_page.dart';
import 'package:detection_mobile/pages/navpages/data_page.dart';
import 'package:detection_mobile/pages/navpages/datawoplate_page.dart';
import 'package:detection_mobile/pages/navpages/user_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;
  final List<Widget> widgetList = const [
    HomePage(),
    DataPage(),
    DataWOPlatePage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: widgetList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: kActiveColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (_index) {
          setState(() {
            currentIndex = _index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.view_day), label: "Plate"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: "Card"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
        ],
      ),
    );
  }
}

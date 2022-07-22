import 'package:detection_mobile/pages/auth/login_page.dart';
import 'package:detection_mobile/pages/auth/register_page.dart';
import 'package:detection_mobile/pages/navpages/dashboard_page.dart';
import 'package:detection_mobile/utils/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const DashboardPage();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helmet.sys',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginPage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => _defaultHome,
        '/register': (BuildContext context) => const RegisterPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => const DashboardPage(),
      },
    );
  }
}

showNewDiAlertDialog(
  BuildContext context,
  String title,
  String message,
  String leftTextButton,
  Function leftOnPressed,
  String rightTextButton,
  Function rightOnPressed,
  int count,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),

        title: const Icon(
          Icons.check_circle,
          size: 50,
          // color: Color.fromARGB(255, 147, 7, 7),
          color: Colors.deepOrangeAccent,
        ),
        content: Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(message), Text("จำนวน $count ครั้ง")],
          ),
        ),

        //Text(message),

        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
            onPressed: () {
              return leftOnPressed();
            },
            child: Text(leftTextButton),
            style: ElevatedButton.styleFrom(
              // primary: Color.fromARGB(255, 144, 12, 2),
              primary: Colors.deepOrangeAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              return rightOnPressed();
            },
            child: Text(rightTextButton),
            style: ElevatedButton.styleFrom(
              // primary: Color.fromARGB(255, 144, 12, 2),
              primary: Colors.deepOrangeAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
        ],
      );
    },
  );
}

showNewNotDiAlertDialog(
  BuildContext context,
  String title,
  String message,
  String leftTextButton,
  Function leftOnPressed,
  String rightTextButton,
  Function rightOnPressed,
  int count,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),

        title: const Icon(
          Icons.cancel,
          size: 50,
          // color: Color.fromARGB(255, 147, 7, 7),
          color: Colors.green      ),
        content: Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(message), Text("จำนวน $count ครั้ง")],
          ),
        ),

        //Text(message),

        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
            onPressed: () {
              return leftOnPressed();
            },
            child: Text(leftTextButton),
            style: ElevatedButton.styleFrom(
              // primary: Color.fromARGB(255, 144, 12, 2),
              primary: Colors.deepOrangeAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              return rightOnPressed();
            },
            child: Text(rightTextButton),
            style: ElevatedButton.styleFrom(
              // primary: Color.fromARGB(255, 144, 12, 2),
              primary: Colors.deepOrangeAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
        ],
      );
    },
  );
}


// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:detection_mobile/pages/auth/login_page.dart';
import 'package:detection_mobile/pages/auth/register_page.dart';
import 'package:detection_mobile/pages/navpages/dashboard_page.dart';
import 'package:detection_mobile/theme.dart';
import 'package:detection_mobile/utils/shared_service.dart';

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
      theme: buildThemeData(),
      // home: const DashboardPage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => _defaultHome,
        '/register': (BuildContext context) => const RegisterPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => const DashboardPage(),
      },
    );
  }
}

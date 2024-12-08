import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? validUser = prefs.getBool('valid_user');
  String? token = prefs.getString('token');
  Widget _defaultHome = home();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => home(),
        // '/home': (BuildContext context) => BottomNavigation(),
      },
    ));
  });
}


import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:login_page/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashBoard.dart';
import 'signInPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // it is used to initialize the app
  SharedPreferences prefs = await SharedPreferences.getInstance(); // it is used to store the data in the app
  runApp(MyApp(
    tokens: prefs.getString('token'), // it is used to get the token from the app
  ));
}

class MyApp extends StatelessWidget {
  final tokens;
  const MyApp({Key? key, this.tokens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: (tokens != null && JwtDecoder.isExpired(tokens) == false)
          ? const Dashboard()
          : const SignInPage(),
    );
  }
}

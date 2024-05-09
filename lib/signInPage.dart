import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login_page/DashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUp.dart';
import 'provider/auth_provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValid = false;
  late SharedPreferences prefs;

  void loginUser() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var token = await AuthProvider.loginUser(
          emailController.text, passwordController.text);
      if (token != null) {
        print('Login successful');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        print('Login failed');
      }
    } else {
      setState(() {
        _isNotValid = true;
      });
    }
  }

  void signUp() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.clamp,
        colors: [
          Color.fromARGB(255, 6, 139, 248),
          Color.fromARGB(201, 255, 255, 255),
        ],
      )),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  enableSuggestions: true, // to disable suggestions
                  autocorrect: true, // to disable autocorrect
                  cursorColor: Colors.grey[200],
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),

                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey[750],
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.grey[750],
                    ),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior
                        .never, // to keep the label at its place
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),

                  keyboardType: false
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  enableSuggestions: false, // to disable suggestions
                  autocorrect: false, // to disable autocorrect
                  cursorColor: Colors.grey[200],
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),

                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey[750],
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.grey[750],
                    ),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior
                        .never, // to keep the label at its place
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),

                  keyboardType: true
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  child: const Text("Sign In"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Don't have an account?"),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextButton(
                  onPressed: () {
                    signUp();
                  },
                  child: const Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}

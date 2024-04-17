import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../services/db_service.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../player/player_root_screen.dart';
import '../props/prop_home_screen.dart';
import '../public/public_user_tournaments_list.dart';
import 'choose_reg_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Color.fromRGBO(154, 153, 153, 1)),
  );

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    // Regex for validating email addresses
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  String? emailError;
  String? passwordError;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextField(
              hintText: 'Enter Email',
              controller: _emailController,
              errorText: emailError,
              borderColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  hintText: 'Enter password',
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  border: outlineInputBorder,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  errorText: passwordError),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Forget password',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _loading
              ? indicator
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                    text: 'Login',
                    onPressed: () {
                      _loginHandler();
                    },
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: "Register",
                  style: const TextStyle(color: Colors.teal),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ChooseRegistrationScreen(),
                          ));
                    },
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PublicViewTouranmentsScreen(),
                  ));
            },
            child: Container(
              color: Colors.teal,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book_online_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Get your ticket now',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _loginHandler() async {
    emailError = _validateEmail(_emailController.text);
    passwordError = _validatePassword(_passwordController.text);

    setState(() {});
    if (emailError == null && passwordError == null) {
      var url =
          Uri.parse('$baseUrl/api/login');
      var params = {
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      };

      try {
        setState(() {
          _loading = true;
        });
        var response = await http.post(url, body: params);
        var jsonResponse = jsonDecode(response.body);



        

        if (response.statusCode == 200) {

          DbService.setLoginId(jsonResponse['loginId']);

          print(DbService.getLoginId());

          setState(() {
            _loading = false;
          });

          if (context.mounted) {
            if (jsonResponse["userRole"] == 3) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayerRootScreen(),
                ),
                (route) => false,
              );
            }

            if (jsonResponse["userRole"] == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PropsHomePage(),
                ),
                (route) => false,
              );
            }

            customSnackBar(context: context, messsage: "Success");
          }
        } else {
          if (context.mounted) {
            customSnackBar(context: context, messsage: jsonResponse["Message"]);
          }

          setState(() {
            _loading = false;
          });
        }
      } catch (e) {
        
        setState(() {
          _loading = false;
        });

        if (context.mounted) {
          customSnackBar(context: context, messsage:'Somthing went wrong' );
        }
      }
    } else {
      setState(() {});
    }
  }
}

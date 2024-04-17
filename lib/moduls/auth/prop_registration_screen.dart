import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../utils/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'login.dart';

class PropRegistrationScreen extends StatefulWidget {
  const PropRegistrationScreen({super.key});

  @override
  State<PropRegistrationScreen> createState() =>
      _PropRegistrationScreenState();
}

class _PropRegistrationScreenState extends State<PropRegistrationScreen> {
  String? emailError;
  String? passwordError;

  bool _obscureText = true;
  bool _loading = false;

  final _nameControllers = TextEditingController();
  final _phoneControllers = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();



  @override
  void dispose() {
    _nameControllers.dispose();
    _phoneControllers.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'SignUp',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              CustomTextField(
                hintText: 'Enter name',
                controller: _nameControllers,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Enter phone',
                controller: _phoneControllers,
                input: TextInputType.number,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Enter age',
                controller: _ageController,
                input: TextInputType.number,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Enter address',
                controller: _addressController,
                minLength: 6,
                maxLength: 20,
               
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Enter email',
                controller: _emailController,
                errorText: emailError,
                
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Enter password',
                controller: _passwordController,
                errorText: passwordError,
                obscureText: _obscureText,
                borderColor: Colors.grey,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Confirm password',
                controller: _confirmPasswordController,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              _loading ? indicator :
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: 'Sign up',
                  onPressed: () {
                    _signUpHandler(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _signUpHandler(BuildContext context)  async{
    
      emailError = validateEmail(_emailController.text);
      passwordError = validatePassword(_passwordController.text);

      setState(() {});

      if (emailError == null &&
          passwordError == null &&
          _nameControllers.text.isNotEmpty &&
          _phoneControllers.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        if (_passwordController.text == _confirmPasswordController.text) {



           setState(() {
          _loading = true;
        });

        var url = Uri.parse('$baseUrl/api/register/proprietor');
        var params = {
          'name': _nameControllers.text.trim(),
          'email': _emailController.text.trim(),
          'mobile': _phoneControllers.text.trim(),
          'address': _addressController.text.trim(),
          'age': _ageController.text.trim(),
          'password': _confirmPasswordController.text.trim(),
        };

        try {
          var response = await http.post(url, body: params);
          if (response.statusCode == 200) {
            var jsonResponse = jsonDecode(response.body);

            if (context.mounted) {
              customSnackBar(
                  context: context, messsage: jsonResponse["Message"]);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            }

            _loading = false;
          } else {
            var jsonResponse = jsonDecode(response.body);
            if (context.mounted) {
              customSnackBar(
                  context: context, messsage: jsonResponse["Message"]);
            }

            setState(() {
              _loading = false;
            });
          }
        } catch (e) {

          print(e);
          if (context.mounted) {
            customSnackBar(context: context, messsage: 'Something went wrong');
          }

          setState(() {
            _loading = false;
          });
        }


         
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password not match')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All fields are required')));
        setState(() {});
      }
    
  }
}

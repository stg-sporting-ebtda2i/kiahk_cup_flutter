import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';
import 'package:piehme_cup_flutter/widgets/widgets_text_field.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<String> _schoolYears = [];

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _schoolYear = '';

  @override
  void initState() {
    AuthService.getSchoolYears().then((schoolYears) {
      if (!mounted) return;
      setState(() {
        for (var schoolYear in schoolYears) {
          _schoolYears.add(schoolYear);
        }
      });
    });
    super.initState();
  }

  bool _isLoading = false;

  Future<void> register(BuildContext context) async {
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _schoolYear.isEmpty) {
      toast('Please fill all fields');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final bool isRegister = await AuthService.register(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
      _schoolYear,
    );

    if (!context.mounted) return;
    setState(() {
      _isLoading = false;
    });

    if (isRegister) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      toast("Registration failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/other_background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Register',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  loginTextField(
                    controller: _usernameController,
                    hint: 'Username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  loginTextField(
                    controller: _passwordController,
                    hint: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  TextSelectionTheme(
                    data: TextSelectionThemeData(
                      selectionColor: Color.fromRGBO(105, 240, 174, 130),
                      selectionHandleColor: Colors.greenAccent,
                    ),
                    child: DropdownMenu(
                      dropdownMenuEntries:
                          _schoolYears.map((String schoolYear) {
                        return DropdownMenuEntry<String>(
                          value: schoolYear,
                          label: schoolYear,
                        );
                      }).toList(),
                      width: double.infinity,
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      onSelected: (String? value) {
                        if (value == null) return;

                        setState(() {
                          _schoolYear = value;
                        });
                      },
                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: Colors.black54,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusColor: Colors.greenAccent,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.greenAccent, width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Button(
                    width: 220,
                    height: 55,
                    text: 'Register',
                    isLoading: _isLoading,
                    onClick: () => register(context),
                    fontSize: 20,
                  ),
                  const SizedBox(height: 45),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Already have an account? Login",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

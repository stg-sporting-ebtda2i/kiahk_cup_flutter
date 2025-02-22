import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';
import 'package:piehme_cup_flutter/widgets/widgets_text_field.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> login(BuildContext context) async {
    if (_usernameController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      if (!mounted) return;
      toast('Please enter both username and password');
      return;
    }

    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final bool isLoginSuccessful = await AuthService.login(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      if (isLoginSuccessful) {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        if (!context.mounted) return;
        toast('Login failed: Incorrect username or password');
      }
    } catch (e) {
      if (!mounted) return;
      toast(e.toString().replaceAll('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _checkIfLoggedIn() async {
    if (await AuthService.hasToken() && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkIfLoggedIn();
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
                    'Login',
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
                  const SizedBox(height: 20),
                  Button(
                    width: 220,
                    height: 55,
                    text: 'Login',
                    isLoading: _isLoading,
                    onClick: () => login(context),
                    fontSize: 20,
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
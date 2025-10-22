import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/utils/data_utils.dart';
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
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
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
        await DataUtils.initApp(context, AppRoutes.home);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            const Image(
              image: AssetImage('assets/form_background2.png'),
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      CustomTextField(
                        hint: 'Username',
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: AppColors.textFieldHint,
                        ),
                        controller: _usernameController,
                        inputType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hint: 'Password',
                        icon: Icon(
                          Icons.lock,
                          color: AppColors.textFieldHint,
                        ),
                        controller: _passwordController,
                        inputType: TextInputType.visiblePassword,
                        obscure: true,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Login',
                        isLoading: _isLoading,
                        onPressed: () => login(context),
                      ),

                      // const SizedBox(height: 35),
                      // GestureDetector(
                      //   onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                      //   child: Text(
                      //     textAlign: TextAlign.center,
                      //     "Don't have an account? Register here",
                      //     style: const TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 16,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';
import 'package:piehme_cup_flutter/widgets/widgets_custom_dropdown.dart';
import 'package:piehme_cup_flutter/widgets/widgets_text_field.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<String> _schoolYears = ['J1', 'J1', 'J1'];

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
      body: SafeArea(
        child: Stack(
          children: [
            const Image(
              image: AssetImage('assets/backgrounds/form_background2.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 175),
                      CustomTextField(
                          hint: 'Username',
                          icon: Icon(Icons.account_circle_rounded),
                          controller: _usernameController,
                          inputType: TextInputType.text),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hint: 'Password',
                        icon: Icon(Icons.lock),
                        controller: _passwordController,
                        inputType: TextInputType.visiblePassword,
                        obscure: true,
                      ),
                      const SizedBox(height: 10),
                      CustomDropdownMenu(
                          items: _schoolYears,
                          value: _schoolYear,
                          onSelected: (schoolYear) {
                            _schoolYear = schoolYear!;
                          },
                          hint: 'School Year'),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Register',
                        isLoading: _isLoading,
                        onPressed: () => register(context),
                      ),
                      const SizedBox(height: 45),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Already have an account? Login",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Dubai'),
                        ),
                      ),
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

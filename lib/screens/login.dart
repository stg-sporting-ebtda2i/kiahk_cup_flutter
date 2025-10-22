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

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Start animation after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                      // Animated form elements
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                          ],
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
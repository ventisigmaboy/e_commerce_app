import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/auth/screen/signup_screen.dart';
import 'package:e_commerce_app/features/auth/service/auth_service.dart';
import 'package:e_commerce_app/features/home/view/admin/screen/admin_screen.dart';
import 'package:e_commerce_app/features/home/view/users/screen/home_screen.dart';
import 'package:e_commerce_app/utils/snackbar_helper.dart';
import 'package:e_commerce_app/widget/check_login_signup.dart';
import 'package:e_commerce_app/widget/custom_button.dart';
import 'package:e_commerce_app/widget/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isPwHidden = true;

  void login() async {
    setState(() {
      isLoading = true;
    });

    User? user = await authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (user != null) {
      final userDoc = await authService.getUserRole(user.uid);
      if (userDoc != null) {
        String role = userDoc['role'];

        if (role == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        SnackBarHelper.messageSnackbar(
          context,
          'Login Failed! Could not fetch user role.',
          isError: true,
        );
      }
    } else {
      SnackBarHelper.messageSnackbar(
        context,
        'Login Failed! Incorrect email or password.',
        isError: true,
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
            },
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login to your account',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                letterSpacing: -2,
              ),
            ),
            Text(
              'It\'s great to see you again.',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefualtPaddin,
          vertical: kDefualtPaddin,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      controller: emailController,
                      title: 'Email',
                      hintText: 'Enter your email address',
                    ),
                    const SizedBox(height: 15),
                    MyTextField(
                      controller: passwordController,
                      obscureText: isPwHidden,
                      title: 'Password',
                      hintText: 'Enter your password',
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPwHidden = !isPwHidden;
                          });
                        },
                        child: Image.asset(
                          isPwHidden
                              ? 'assets/icons/hide.png'
                              : 'assets/icons/hidden.png',
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CheckLogInSignUp(
                      firText: 'Forgot your password? ',
                      secText: 'Reset your password',
                    ),
                    const SizedBox(height: 25),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                          onPressed: login,
                          textColor: AppColors.primary0,
                          text: 'Login',
                          color: AppColors.primary200,
                          padding: EdgeInsets.zero,
                        ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.8,
                              color: AppColors.primary100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text('Or'),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.8,
                              color: AppColors.primary100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: 'Login with Google',
                      textColor: AppColors.primary900,
                      isOutlined: true,
                      borderColor: AppColors.primary200,
                      onPressed: () {},
                      icon: Image.asset('assets/icons/google.png', width: 22),
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      text: 'Login with Facebook',
                      textColor: AppColors.primary900,
                      isOutlined: true,
                      borderColor: AppColors.primary200,
                      onPressed: () {},
                      icon: Image.asset('assets/icons/facebook.png', width: 22),
                    ),
                  ],
                ),
              ),
            ),
            CheckLogInSignUp(
              mainAxisAlignment: MainAxisAlignment.center,
              firText: 'Don\'t have an account? ',
              secText: 'Join',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

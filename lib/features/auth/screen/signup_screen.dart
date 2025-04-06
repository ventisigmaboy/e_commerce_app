import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/auth/screen/login_screen.dart';
import 'package:e_commerce_app/features/auth/service/auth_service.dart';
import 'package:e_commerce_app/utils/snackbar_helper.dart';
import 'package:e_commerce_app/widget/check_login_signup.dart';
import 'package:e_commerce_app/widget/custom_button.dart';
import 'package:e_commerce_app/widget/my_text_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = "User"; // defualt selected
  bool isLoading = false;
  bool isPwHidden = true;

  // instance auth service for authication logic
  final AuthService authService = AuthService();

  // sign up funcition to handle user registation

  void registerUser() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String role = selectedRole;

    // Call signUp function
    String? result = await authService.signUp(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    setState(() {
      isLoading = false; // Hide loading indicator
    });

    if (result == "Success") {
      SnackBarHelper.messageSnackbar(
        context,
        'Signup Successful! $result',
        isError: true,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      
    } else {
      SnackBarHelper.messageSnackbar(
        context,
        'Signup Failed! $result',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create an account',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                letterSpacing: -2,
              ),
            ),
            Text('Let\'s create your account.', style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefualtPaddin,
          vertical: kDefualtPaddin,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Full name and role row
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: MyTextField(
                            controller: nameController,
                            title: 'Full Name',
                            hintText: 'Enter your full name',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Role",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  height: 2,
                                ),
                              ),
                              DropdownButtonFormField<String>(
                                borderRadius: BorderRadius.circular(12),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                ),
                                items:
                                    ['User', 'Admin']
                                        .map(
                                          (role) => DropdownMenuItem(
                                            value: role,
                                            child: Text(role),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (String? newValue) {
                                  // Handle role selection
                                  setState(() {
                                    selectedRole = newValue!;
                                  });
                                },
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                hint: Text(
                                  'Select role',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    MyTextField(
                      controller: emailController,
                      title: 'Email',
                      hintText: 'Enter your email address',
                    ),
                    const SizedBox(height: 15),
                    MyTextField(
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
                      obscureText: isPwHidden,
                      controller: passwordController,
                      title: 'Password',
                      hintText: 'Enter your password',
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'By signing up you agree to our ',
                            style: TextStyle(color: AppColors.primary500),
                          ),
                          TextSpan(
                            text: 'Terms, Privacy Policy, ',
                            style: TextStyle(
                              color: AppColors.primary900,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: 'and '),
                          TextSpan(
                            text: 'Cookie Use',
                            style: TextStyle(
                              color: AppColors.primary900,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                          onPressed: registerUser,
                          textColor: AppColors.primary0,
                          text: 'Create an Account',
                          color: AppColors.primary200,
                          padding: EdgeInsets.zero,
                        ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          Expanded(
                            // Takes available width
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
                      text: 'Sign Up with Google',
                      textColor: AppColors.primary900,
                      isOutlined: true,
                      borderColor: AppColors.primary200,
                      onPressed: () {},
                      icon: Image.asset('assets/icons/google.png', width: 22),
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      text: 'Sign Up with Facebook',
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
            Center(
              child: CheckLogInSignUp(
                mainAxisAlignment: MainAxisAlignment.center,
                firText: 'Already have an account? ',
                secText: 'Log in.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

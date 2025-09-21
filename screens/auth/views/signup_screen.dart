import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/route/route_constants.dart';
import 'package:shop_app/services/auth_service.dart';
import '../../../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/signUp_dark.png",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let’s get started!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Please enter your valid data in order to create an account.",
                  ),
                  const SizedBox(height: defaultPadding),

                  // ====== الفورم ======
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // إدخال الإيميل
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                          validator: (value) =>
                              value!.isEmpty ? "Enter your email" : null,
                        ),
                        const SizedBox(height: defaultPadding),

                        // إدخال الباسورد
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: "Password"),
                          validator: (value) =>
                              value!.isEmpty ? "Enter your password" : null,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: defaultPadding),

                  // موافقة على الشروط
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (value) {
                          setState(() {
                            agreeToTerms = value ?? false;
                          });
                        },
                        value: agreeToTerms,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "I agree with the",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, termsOfServicesScreenRoute);
                                  },
                                text: " Terms of service ",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(text: "& privacy policy."),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 2),

                  // زر متابعة
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (!agreeToTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("You must agree to terms"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        // تسجيل المستخدم
                        var user = await _authService.signUp(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );

                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Account Created Successfully ✅"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          // الانتقال للصفحة الرئيسية بعد التسجيل
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            entryPointScreenRoute,
                            (_) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Signup Failed ❌"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Continue"),
                  ),

                  const SizedBox(height: defaultPadding),

                  // رابط لتسجيل الدخول إذا عنده حساب
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, logInScreenRoute);
                        },
                        child: const Text("Log in"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/route/route_constants.dart';
import 'package:shop_app/services/auth_service.dart'; // استدعاء خدمة Firebase Authentication

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // مفتاح الفورم

  // كنترولرز عشان ناخذ الإيميل والباسورد
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService(); // إنشاء نسخة من AuthService

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة الصفحة
            Image.asset(
              "assets/images/login_dark.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Log in with your data that you entered during your registration.",
                  ),
                  const SizedBox(height: defaultPadding),

                  // ======= الفورم =======
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // إدخال الإيميل
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Enter your email" : null,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: defaultPadding),

                        // إدخال الباسورد
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Enter your password" : null,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: defaultPadding / 2),

                  // رابط استرجاع كلمة المرور
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text("Forgot password"),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, passwordRecoveryScreenRoute);
                      },
                    ),
                  ),

                  SizedBox(
                    height:
                        size.height > 700 ? size.height * 0.1 : defaultPadding,
                  ),

                  // زر تسجيل الدخول
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // محاولة تسجيل الدخول عبر Firebase
                        var user = await _authService.signIn(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );

                        if (user != null) {
                          // تسجيل الدخول ناجح
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login Successful! ✅"),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // الانتقال للصفحة الرئيسية
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            entryPointScreenRoute,
                            (route) => false,
                          );
                        } else {
                          // تسجيل الدخول فشل
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login Failed ❌"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Log in"),
                  ),

                  const SizedBox(height: defaultPadding),

                  // رابط التسجيل إذا ما عنده حساب
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, signUpScreenRoute);
                        },
                        child: const Text("Sign up"),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/services/auth_service.dart';
import '../../../../constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // Email
          TextFormField(
            controller: _emailController,
            validator: emaildValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email address",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Message.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Password
          TextFormField(
            controller: _passwordController,
            validator: passwordValidator.call,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Lock.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 1.5),

          // زر التسجيل
          ElevatedButton(
            onPressed: () async {
              if (widget.formKey.currentState!.validate()) {
                if (!agreeToTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You must agree to terms")),
                  );
                  return;
                }

                try {
                  var user = await _authService.signUp(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );

                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Account Created Successfully ✅")),
                    );
                    // TODO: انتقل للصفحة الرئيسية
                    // Navigator.pushReplacementNamed(context, entryPointScreenRoute);
                  }
                } catch (e) {
                  // بدال كلمة "Error" رح يطبع السبب الحقيقي
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Signup Failed ❌\n$e")),
                  );
                }
              }
            },
            child: const Text("Sign up"),
          ),
        ],
      ),
    );
  }
}

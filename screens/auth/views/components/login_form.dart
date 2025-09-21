import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/services/auth_service.dart';
import '../../../../constants.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

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
                      BlendMode.srcIn),
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
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 1.5),

          // زر الدخول
          ElevatedButton(
            onPressed: () async {
              if (widget.formKey.currentState!.validate()) {
                try {
                  var user = await _authService.signIn(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );

                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Successful ✅")),
                    );
                    // TODO: انتقل للصفحة الرئيسية
                    // Navigator.pushReplacementNamed(context, entryPointScreenRoute);
                  }
                } catch (e) {
                  // هيك بيظهر السبب الحقيقي من Firebase
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login Failed ❌\n$e")),
                  );
                }
              }
            },
            child: const Text("Log in"),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/app_dialog.dart';
import 'package:tasky_app/core/network/result.dart';
import 'package:tasky_app/features/auth/data/firebase/auth_firebase_database.dart';
import 'package:tasky_app/features/auth/screens/home_screen.dart';
import 'package:tasky_app/features/auth/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff404147),
              ),
            ),

            TextFormFieldWidget(
              title: 'Email',
              hintText: 'enter email...',
              controller: emailController,
              myValidator: (value) {},
              keyboardType: TextInputType.emailAddress,
            ),

            TextFormFieldWidget(
              title: 'Password',
              hintText: 'enter password...',
              controller: passwordController,
              myValidator: (value) {},
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              isPassword: true,
            ),

            SizedBox(height: 54),
            MaterialButton(
              onPressed: _login,
              color: Color(0xff5F33E1),
              minWidth: double.infinity,
              height: 48,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 3,
          children: [
            Text(
              'Don\'t have an account?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff716C7E),
              ),
            ),
            Text(
              'Register',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff5F33E1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    AppDialog.showLoading(context);
    final result = await AuthFunctions.loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    Navigator.of(context).pop();
    switch (result) {
      case Success<String>():
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      case ErrorState<String>():
        AppDialog.showError(context: context, message: result.error);
        break;
    }
  }
}

typedef Validator = String? Function(String?);

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final String title;
  final TextInputType keyboardType;
  bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final Validator myValidator;

  TextFormFieldWidget({
    required this.title,
    required this.hintText,
    required this.controller,
    required this.myValidator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    super.key,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff716C7E),
          ),
        ),

        TextFormField(
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),

          obscureText: widget.obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: Colors.grey.shade100,
            filled: true,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      widget.obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xff454A4F),
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                  )
                : null,

            contentPadding: const EdgeInsets.all(15),
            enabledBorder: outlineInputBorder(
              color: Color(0xff716C7E),
              radius: 10,
              width: 1,
            ),
            focusedBorder: outlineInputBorder(
              color: Color(0xff5F33E1),
              radius: 10,
              width: 1,
            ),
            errorBorder: outlineInputBorder(
              color: Color(0xffFF4949),
              radius: 10,
              width: 1,
            ),
          ),
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          validator: widget.myValidator,
        ),
      ],
    );
  }

  OutlineInputBorder outlineInputBorder({
    required double radius,
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

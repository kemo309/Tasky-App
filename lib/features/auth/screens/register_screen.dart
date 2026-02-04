import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/features/auth/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff404147),
              ),
            ),

            TextFormFieldWidget(
              title: 'Username',
              hintText: 'enter username...',
              controller: usernameController,
              myValidator: (value) {},
              keyboardType: TextInputType.text,
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

            TextFormFieldWidget(
              title: 'Confirm Password',
              hintText: 'confirm password...',
              controller: confirmPasswordController,
              myValidator: (value) {},
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              isPassword: true,
            ),

            SizedBox(height: 54),
            MaterialButton(
              onPressed: () async {
                print(usernameController.text);
                print(emailController.text);
                print(passwordController.text);
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              color: Color(0xff5F33E1),
              minWidth: double.infinity,
              height: 48,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Register',
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
          ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 3,
          children: [
            Text(
              'Already have an account? ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff716C7E),
              ),
            ),
            Text(
              'Login',
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
      crossAxisAlignment: .start,
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

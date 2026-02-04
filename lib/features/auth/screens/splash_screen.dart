import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1600), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5F33E1),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInLeft(
              duration: Duration(milliseconds: 900),
              child: Image.asset('assets/icons/Task.png', scale: 2),
            ),
            BounceInDown(
              delay: Duration(milliseconds: 900),
              duration: Duration(milliseconds: 600),
              from: 50,
              child: Image.asset('assets/icons/y.png', scale: 2),
            ),
          ],
        ),
      ),
    );
  }
}

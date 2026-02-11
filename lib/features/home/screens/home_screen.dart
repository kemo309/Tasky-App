import 'package:flutter/material.dart';
import 'package:tasky_app/core/helper/validator_app.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/features/auth/screens/login_screen.dart';
import 'package:tasky_app/features/home/widgets/bottom_sheet_add_task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.logo, width: 90),
                  const Spacer(),
                  Image.asset(AppAssets.logout, height: 40, width: 40),
                  SizedBox(width: 2),
                  Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFF4949),
                    ),
                  ),
                ],
              ),
              EmptyHomeScreen(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,

            builder: (context) => BottomSheetAddTask(),
          );
        },
        backgroundColor: Color(0xff05F33E1),
        child: Icon(Icons.add, size: 30, color: Color(0xffFFFFFF)),
      ),
    );
  }
}

class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100),
        Image.asset(AppAssets.emptyHome),
        SizedBox(height: 15),
        Text(
          'What do you want to do today?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xff404147),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Tap + to add your tasks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff404147),
          ),
        ),
      ],
    );
  }
}

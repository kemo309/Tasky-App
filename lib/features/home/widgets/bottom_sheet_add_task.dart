import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/helper/validator_app.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/features/auth/screens/login_screen.dart';
import 'package:tasky_app/features/home/widgets/alert_dialog_task_priority.dart';

class BottomSheetAddTask extends StatefulWidget {
  const BottomSheetAddTask({super.key});

  @override
  State<BottomSheetAddTask> createState() => _BottomSheetAddTaskState();
}

class _BottomSheetAddTaskState extends State<BottomSheetAddTask> {
  DateTime selectedDate = DateTime.now();
  int selectedPriority = 1;
  var title = TextEditingController();
  var description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xff404147),
            ),
          ),
          SizedBox(height: 20),
          TextFormFieldWidget(
            title: "Title",
            hintText: "Enter Task Title",
            controller: title,
            myValidator: ValidatorApp.validateName,
          ),
          SizedBox(height: 10),
          TextFormFieldWidget(
            title: "Description",
            hintText: "Enter Task Description",
            controller: description,
            myValidator: ValidatorApp.validateName,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _IconAddTask(
                imagePath: AppAssets.timer,
                onTap: () async {
                  selectedDate =
                      await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        initialDate: DateTime.now(),
                      ) ??
                      DateTime.now();
                },
              ),
              SizedBox(width: 10),
              _IconAddTask(
                imagePath: AppAssets.flag,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialogTaskPriority(
                      getPriority: (p) {
                        selectedPriority = p;
                      },
                    ),
                  );
                },
              ),
              const Spacer(),
              _IconAddTask(
                imagePath: AppAssets.send,
                onTap: () {
                  log(selectedDate.toString());
                  log(selectedPriority.toString());
                  log(title.text);
                  log(description.text);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconAddTask extends StatelessWidget {
  _IconAddTask({required this.imagePath, required this.onTap});
  String imagePath;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(imagePath, height: 24, width: 24, fit: BoxFit.contain),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_assets.dart';

class AlertDialogTaskPriority extends StatefulWidget {
  const AlertDialogTaskPriority({super.key, required this.getPriority});
  final void Function(int) getPriority;

  @override
  State<AlertDialogTaskPriority> createState() =>
      _AlertDialogTaskPriorityState();
}

class _AlertDialogTaskPriorityState extends State<AlertDialogTaskPriority> {
  final List<int> priorities = List.generate(10, (index) => index + 1);
  int selectedPriority = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Task Priority",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff404147),
            ),
          ),
          const Divider(),
        ],
      ),
      content: Wrap(
        children: priorities
            .map<_ItmTaskpriority>(
              (index) => _ItmTaskpriority(
                index,
                selectedPriority == index,
                onTap: () {
                  selectedPriority = index;
                  widget.getPriority(selectedPriority);
                  setState(() {});
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ItmTaskpriority extends StatelessWidget {
  const _ItmTaskpriority(this.index, this.isSelected, {this.onTap});
  final int index;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        margin: const EdgeInsets.only(right: 7, bottom: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff05F33E1) : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Color(0xff05F33E1) : Colors.grey,
          ),
        ),
        child: Column(
          spacing: 7,
          children: [
            Image.asset(
              AppAssets.flag,
              height: 24,
              width: 24,
              color: isSelected ? Color(0xffFFFFFF) : null,
            ),
            Text(
              index.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isSelected ? Color(0xffFFFFFF) : Color(0xff404147),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

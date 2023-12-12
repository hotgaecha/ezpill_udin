/// 페이지 몇 개 더 만들어야함.

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputBirthWidget extends StatefulWidget {
  const InputBirthWidget({super.key});

  @override
  State<InputBirthWidget> createState() => _InputBirthWidgetState();
}

class _InputBirthWidgetState extends State<InputBirthWidget> {
  DateTime? inputDate;

  @override
  void initState() {
    super.initState();
  }

  void openDatePicker(BuildContext context) {
    BottomPicker.date(
      title: '생년월일을 입력해주세요.',
      dateOrder: DatePickerDateOrder.ydm,
      pickerTextStyle: const TextStyle(
        color: Colors.black,
      ),
      titleStyle: const TextStyle(
        color: Colors.black,
      ),
      onSubmit: (value) {
        setState(() {
          inputDate = value;
        });
      },
      bottomPickerTheme: BottomPickerTheme.orange,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(40, 90, 40, 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => openDatePicker(context),
            child: const Text(
              "생년월일",
              style: TextStyle(color: Colors.grey, fontSize: 25),
            ),
          ),

          /// inputDate Debug
          Text(inputDate?.toString().split(" ")[0] ?? ""),
        ],
      ),
    );
  }
}

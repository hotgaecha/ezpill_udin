import 'package:flutter/material.dart';

class InputNameWidget extends StatefulWidget {
  const InputNameWidget({super.key});

  @override
  State<InputNameWidget> createState() => _InputNameWidgetState();
}

class _InputNameWidgetState extends State<InputNameWidget> {
  String inputName = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(40, 90, 40, 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Text(
          //   '성함을 입력해주세요.',
          //   style: TextStyle(
          //       fontFamily: "NanumSquare",
          //       fontSize: 25,
          //       fontWeight: FontWeight.w500),
          // ),
          // const SizedBox(
          //   height: 100,
          // ),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            width: 300,
            child: TextField(
              style: const TextStyle(fontSize: 25, color: Colors.black),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: '성함을 입력해주세요'),
              onChanged: (String str) {
                setState(() => inputName = str);
              },
            ),
          ),

          ///  inputName Debug
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            width: 300,
            child: Text(
              inputName,
              style: const TextStyle(fontSize: 32),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const InputNameWidget(),
              //   ),
              // );
            },
            child: Container(
              width: double.maxFinite,
              height: 60,
              decoration: const BoxDecoration(color: Color(0xfff9b53a)),
              alignment: Alignment.center,
              child: const Text(
                "다음",
                style: TextStyle(
                    fontFamily: "GmarketSans",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

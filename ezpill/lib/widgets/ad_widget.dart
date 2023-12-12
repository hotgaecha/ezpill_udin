import 'dart:async';

import 'package:flutter/material.dart';

class AD extends StatefulWidget {
  const AD({super.key});

  @override
  State<AD> createState() => _ADState();
}

class _ADState extends State<AD> {
  late Timer timer;

  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        int currentPage = controller.page!.toInt();
        int nextPage = currentPage + 1;

        if (nextPage > 2) {
          nextPage = 0;
        }

        controller.animateToPage(nextPage,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: controller,
          children: [1, 2, 3]
              .map(
                (e) => Image.asset(
                  'assets/icons/icon$e.png', //  상대경로로 변경하기
                  fit: BoxFit.contain,
                ),
              )
              .toList()),
    );
  }
}

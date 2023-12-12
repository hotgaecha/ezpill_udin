import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class StressListScreen extends StatelessWidget {
  const StressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "Stress"),
      ),
      body: Column(
        children: [
          Image(
            image: NetworkImage(
                "https://cdn-icons-png.flaticon.com/128/7021/7021107.png"),
            width: 100,
          ),
        ],
      ),
    );
  }
}

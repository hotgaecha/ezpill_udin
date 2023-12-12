import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class CounselScreen extends StatelessWidget {
  const CounselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "Counsel"),
      ),
      body: Column(
        children: [
          Text("Counsel Page"),
        ],
      ),
    );
  }
}

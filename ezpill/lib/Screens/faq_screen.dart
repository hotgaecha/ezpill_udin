import 'package:ezpill/widgets/app_bar_widget.dart';

import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "FAQ"),
      ),
      body: Column(
        children: [
          Text("FAQ Page"),
        ],
      ),
    );
  }
}

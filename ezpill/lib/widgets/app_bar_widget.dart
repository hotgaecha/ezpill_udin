import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String screentitle;
  const AppBarWidget({
    super.key,
    required this.screentitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.5,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      centerTitle: true,
      title: Text(screentitle),
    );
  }
}

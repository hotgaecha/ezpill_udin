import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(
          screentitle: "Profile",
        ),
      ),
      body: Column(
        children: [
          Text("Profile Page"),
        ],
      ),
    );
  }
}

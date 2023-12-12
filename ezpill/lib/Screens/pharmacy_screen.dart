import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:ezpill/widgets/google_map_widget.dart';
import 'package:flutter/material.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(screentitle: "Pharmacy"),
        ),
        body: GoogleMapWidget());
  }
}

import 'package:ezpill/Screens/faq_screen.dart';
import 'package:ezpill/Screens/pharmacy_screen.dart';
import 'package:ezpill/Screens/profile_screen.dart';
import 'package:ezpill/Screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';

class BottomnavBarWidget extends StatefulWidget {
  final String firebaseUid;

  const BottomnavBarWidget({Key? key, required this.firebaseUid})
      : super(key: key);

  @override
  State<BottomnavBarWidget> createState() => _BottomnavBarWidgetState();
}

class _BottomnavBarWidgetState extends State<BottomnavBarWidget> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // print('$index Pressed.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFf9b53a),
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.account_circle)),
          label: '내 정보',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FAQScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.question_answer)),
          label: 'FAQ',
        ),
        BottomNavigationBarItem(
          icon: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PharmacyScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.place)),
          label: '주변 약국',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShoppingCartScreen(firebaseUid: widget.firebaseUid),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart)),
          label: '장바구니',
        ),
      ],
      selectedItemColor: Colors.red,
      unselectedItemColor: const Color(0xFFf9b53a),
      showUnselectedLabels: true,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}

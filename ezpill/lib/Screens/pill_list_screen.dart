import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pill_detail_screen.dart'; // DetailScreen 파일 import

class PillListScreen extends StatefulWidget {
  final String nutrientName;

  const PillListScreen(this.nutrientName, {super.key});

  @override
  _PillListScreenState createState() => _PillListScreenState();
}

class _PillListScreenState extends State<PillListScreen> {
  List<Map<String, dynamic>> nutrientInfo = [];

  @override
  void initState() {
    super.initState();
    fetchNutrientInfo(widget.nutrientName);
  }

  Future<void> fetchNutrientInfo(String nutrientName) async {
    try {
      // Django API URL
      String pillDataUrl =
          'http://ec2-3-129-91-47.us-east-2.compute.amazonaws.com/ezpill';

      var response = await http.get(
        Uri.parse('$pillDataUrl/api/products/$nutrientName/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        }, // UTF-8 설정
      );

      if (response.statusCode == 200) {
        var jsonResponse =
            json.decode(utf8.decode(response.bodyBytes)); // UTF-8 디코딩
        setState(() {
          nutrientInfo = List<Map<String, dynamic>>.from(jsonResponse);
        });
      } else {
        print('Failed to load nutrient information: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(screentitle: '${widget.nutrientName} 정보'),
      ),
      body: nutrientInfo.isEmpty
          ? const Center(child: CircularProgressIndicator()) // 로딩 중이면 스피너 표시
          : ListView.builder(
              itemCount: nutrientInfo.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/${nutrientInfo[index]['product_id']}.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title:
                      Text(nutrientInfo[index]['product_title'] ?? 'Unknown'),
                  subtitle: Text(
                      '가격: \\${nutrientInfo[index]['product_price']} | 개별 가격: \\${nutrientInfo[index]['product_per_price']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PillDetailScreen(productInfo: nutrientInfo[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

import 'package:ezpill/widgets/graph_widget.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> intakeDoseList = [
      //  {key : value_string, key : value_dynamic}
      {
        'name': '비타민B',
        'recommendedIntake': 800,
        'currentIntake': 2000,
        'upperIntake': 4000,
      },
      {
        'name': '비타민B',
        'recommendedIntake': 800,
        'currentIntake': 2000,
        'upperIntake': 4000,
      },
      {
        'name': '비타민B',
        'recommendedIntake': 800,
        'currentIntake': 2000,
        'upperIntake': 4000,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 150, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '매일 이만큼의 영양성분을\n보충할 수 있어요.',
                    style: TextStyle(
                        fontFamily: "NanumSquare",
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 430,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // 한 줄에 1개의 요소를 표시
                      childAspectRatio: 7,
                      mainAxisSpacing: 16, // 수직 간격
                    ),
                    itemCount: intakeDoseList.length,
                    itemBuilder: (context, index) {
                      return GraphWidget(
                        ingredientName: intakeDoseList[index]['name'],
                        recommendedIntake: intakeDoseList[index]
                            ['recommendedIntake'],
                        currentIntake: intakeDoseList[index]['currentIntake'],
                        upperIntake: intakeDoseList[index]['upperIntake'],
                      );
                    },
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.maxFinite,
                height: 60,
                decoration: const BoxDecoration(color: Color(0xfff9b53a)),
                alignment: Alignment.center,
                child: const Text(
                  "구매하기",
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
      ),
    );
  }
}

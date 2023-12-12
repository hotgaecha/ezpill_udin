import 'package:flutter/material.dart';

class GraphWidget extends StatelessWidget {
  final String ingredientName;
  final int recommendedIntake;
  final int currentIntake;
  final int upperIntake;

  const GraphWidget({
    super.key,
    required this.ingredientName,
    required this.recommendedIntake,
    required this.currentIntake,
    required this.upperIntake,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            ingredientName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontFamily: 'NanumSquare',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                const Text(
                  '권장 섭취량',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'NanumSquare',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(
                  width: (1 - recommendedIntake / upperIntake) * 100,
                ),
                const Text(
                  '섭취 상한선',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'NanumSquare',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Stack(
              children: [
                Container(
                  width: 210,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: currentIntake / upperIntake * 210,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9B53A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: currentIntake / upperIntake * 210,
                  child: Text(
                    '${currentIntake}IU',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'NanumSquare',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Text(
                  '${recommendedIntake}IU',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'NanumSquare',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(
                  width: (1 - recommendedIntake / upperIntake) * 100 + 25,
                ),
                Text(
                  '${upperIntake}IU',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'NanumSquare',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

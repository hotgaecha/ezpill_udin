import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String ingredientName;
  final dynamic ingredientImage;
  final String ingredientText;

  const ImageButton({
    super.key,
    required this.ingredientName,
    required this.ingredientImage,
    required this.ingredientText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 8,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(ingredientImage),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Text(
            ingredientName,
            style: TextStyle(
              color: Colors.black,
              fontSize: (ingredientName.length > 3 ? 22 : 25),
              fontFamily: 'Gmarket Sans TTF',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Text(
            ingredientText,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 12,
              fontFamily: 'NanumSquare',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }
}


// ElevatedButton(
            
            
//             child = Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Opacity(
//                   opacity: 0.4,
//                   child: Image.asset(
//                     nutritionList.elementAt(index)['image'],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   nutritionList[index]['name'] as String, // 타입 캐스팅
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           );
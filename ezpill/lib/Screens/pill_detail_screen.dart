import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class PillDetailScreen extends StatelessWidget {
  final Map<String, dynamic> productInfo;

  const PillDetailScreen({super.key, required this.productInfo}); // 생성자 추가

  @override
  Widget build(BuildContext context) {
    List<String> reviews =
        (productInfo['review'] as String?)?.split('\n') ?? [];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
            screentitle: productInfo['product_title'] ?? 'Unknown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200, // 이미지 높이 조정
                child: Image.asset(
                  'assets/images/${productInfo['product_id']}.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '가격: \$${productInfo['product_price']} | 개별 가격: \$${productInfo['product_per_price']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                '상품 설명:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                productInfo['product_usage'] ??
                    'No usage information available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                '주의 사항:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                productInfo['product_precautions'] ??
                    'No precaution information available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                '성분 정보:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                productInfo['product_ingredient_information']
                        ?.replaceAll('\\n', '\n') ??
                    'No ingredient information available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                '리뷰:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reviews.map((review) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      review.trim(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context, productInfo); // 선택된 제품을 BasketScreen으로 반환
                },
                child: const Text('내 영양제로 추가'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
